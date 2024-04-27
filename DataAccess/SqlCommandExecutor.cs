using System;
using System.Data;
using System.Data.SqlClient;
using System.Transactions;

namespace DataAccess
{
    public class SqlCommandExecutor
    {
        private readonly string connectionString;

        public SqlCommandExecutor(string server, string database)
           : this($"Server={server};Database={database};Integrated Security=SSPI;")
        {
        }

        public SqlCommandExecutor(string connectionString)
        {
            if (string.IsNullOrWhiteSpace(connectionString))
                throw new ArgumentException("The parameter cannot be null or empty.", nameof(connectionString));

            this.connectionString = connectionString;
        }

        public void ExecuteNonQuery(IDataDelegate dataDelegate)
        {
            using (var transaction = new TransactionScope())
            {
                using (var connection = new SqlConnection(connectionString))
                {
                    using (var sqlCommand = GenerateSqlCommand(dataDelegate.ProcedureName, connection))
                    {
                        dataDelegate.PrepareCommand(new Command(sqlCommand));

                        connection.Open();

                        sqlCommand.ExecuteNonQuery();

                        transaction.Complete();
                    }
                }
            }
        }

        public T ExecuteNonQuery<T>(INonQueryDataDelegate<T> dataDelegate)
        {
            using (var transaction = new TransactionScope())
            {
                using (var connection = new SqlConnection(connectionString))
                {
                    using (var sqlCommand = GenerateSqlCommand(dataDelegate.ProcedureName, connection))
                    {
                        var command = new Command(sqlCommand);

                        dataDelegate.PrepareCommand(command);

                        connection.Open();

                        sqlCommand.ExecuteNonQuery();

                        transaction.Complete();

                        return dataDelegate.Translate(command);
                    }
                }
            }
        }

        public T ExecuteReader<T>(IDataReaderDelegate<T> dataDelegate)
        {
            using (var connection = new SqlConnection(connectionString))
            {
                using (var sqlCommand = GenerateSqlCommand(dataDelegate.ProcedureName, connection))
                {
                    var command = new Command(sqlCommand);

                    dataDelegate.PrepareCommand(command);

                    connection.Open();

                    var reader = sqlCommand.ExecuteReader();

                    return dataDelegate.Translate(command, new DataRowReader(reader));
                }
            }
        }

        private SqlCommand GenerateSqlCommand(string procedureName, SqlConnection connection)
        {
            return new SqlCommand(procedureName, connection)
            {
                CommandType = CommandType.StoredProcedure
            };
        }
    }
}
