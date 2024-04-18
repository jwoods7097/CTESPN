using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Data;
using System.Transactions;

namespace DataAccess.Tests
{
    [TestClass]
    public class DataRowReaderTest
    {
        const string connectionString = @"Server=(localdb)\MSSQLLocalDb;Database=CTESPN;Integrated Security=SSPI;";

        private TransactionScope? transaction;

        [TestInitialize]
        public void InitializeTest()
        {
            transaction = new TransactionScope();
        }

        [TestCleanup]
        public void CleanupTest()
        {
            if (transaction is not null) transaction.Dispose();
        }

        [TestMethod]
        public void EnsureDateTimeValuesWork()
        {
            var sql = @"
DECLARE @DTO DATETIMEOFFSET = @InputDto;

DECLARE
   @DateTime2 DATETIME2 = @DTO,
   @DateTimeOffset DATETIMEOFFSET = @DTO;

SELECT @DateTime2 AS DateTime2Value, @DateTimeOffset AS DateTimeOffsetValue;
";
            var dto = DateTimeOffset.Now;

            void addParameters(Command c)
            {
                c.Parameters.AddWithValue("@InputDto", dto);
            }

            (DateTime, DateTimeOffset) translator(IDataRowReader r)
            {
                return
                (
                   r.GetDateTime("DateTime2Value", DateTimeKind.Local),
                   r.GetDateTimeOffset("DateTimeOffsetValue")
                );
            }

            var testDelegate = new SqlTextDataRowDelegate<(DateTime, DateTimeOffset)>(sql, addParameters, translator);
            var executor = new SqlCommandExecutor(connectionString);
            var results = executor.ExecuteReader(testDelegate);

            Assert.AreEqual(dto.LocalDateTime, results.Item1, "DateTime2 values are not equal.");
            Assert.AreEqual(dto, results.Item2, "DateTimeOffset values are not equal.");
        }

        [TestMethod]
        public void EnsureGetValueWithNullsWork()
        {
            var sql = @"
DECLARE
   @IntValue INT = NULL,
   @NVarcharValue NVARCHAR(10) = NULL,
   @DateTimeOffsetValue DATETIMEOFFSET = NULL;

SELECT @IntValue AS IntValue, @NVarcharValue AS NVarcharValue, @DateTimeOffsetValue AS DateTimeOffsetValue;
";

            (int, string, DateTimeOffset) translator(IDataRowReader r)
            {
                return
                (
                   r.GetValue("IntValue", int.MinValue),
                   r.GetValue("NVarcharValue", string.Empty),
                   r.GetValue("DateTimeOffsetValue", DateTimeOffset.MinValue)
                );
            }

            var testDelegate = new SqlTextDataRowDelegate<(int, string, DateTimeOffset)>(sql, translator);
            var executor = new SqlCommandExecutor(connectionString);
            var results = executor.ExecuteReader(testDelegate);

            Assert.AreEqual(int.MinValue, results.Item1, "Int values are not equal.");
            Assert.AreEqual(string.Empty, results.Item2, "NVarchar values are not equal.");
            Assert.AreEqual(DateTimeOffset.MinValue, results.Item3, "DateTimeOffset values are not equal.");
        }

        private class SqlTextDataRowDelegate<T> : DataReaderDelegate<T>
        {
            private readonly Action<Command> addParameters;
            private readonly Func<IDataRowReader, T> translateRow;


            public SqlTextDataRowDelegate(string sql, Func<IDataRowReader, T> translateRow)
               : this(sql, c => { }, translateRow)
            {
            }

            public SqlTextDataRowDelegate(string sql, Action<Command> addParameters, Func<IDataRowReader, T> translateRow)
               : base(sql)
            {
                this.addParameters = addParameters;
                this.translateRow = translateRow;
            }

            public override void PrepareCommand(Command command)
            {
                base.PrepareCommand(command);

                command.CommandType = CommandType.Text;
                addParameters(command);
            }

            public override T Translate(Command command, IDataRowReader reader)
            {
                if (!reader.Read())
                    throw new RecordNotFoundException("Test Row");

                return translateRow(reader);
            }
        }
    }
}
