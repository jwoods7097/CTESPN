using System;
using System.Collections.Generic;
using System.Transactions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using DataAccess;
using Data.Models;
using Data;

namespace PersonData.Tests
{
    [TestClass]
    public class SqlPersonRepositoryTest
    {
        const string connectionString = @"Server=(localdb)\MSSQLLocalDb;Database=CTESPN;Integrated Security=SSPI;";

        private static string GetTestString() => Guid.NewGuid().ToString("N");

        private SqlPlayerRepository repo;
        private TransactionScope transaction;

        [TestInitialize]
        public void InitializeTest()
        {
            repo = new SqlPlayerRepository(connectionString);

            transaction = new TransactionScope();
        }

        [TestCleanup]
        public void CleanupTest()
        {
            transaction.Dispose();
        }

        [TestMethod]
        public void CreatePersonShouldWork()
        {
            var ptid = PlayerType.Midfielder;
            var name = GetTestString();

            var actual = repo.CreatePlayer(ptid, name);

            Assert.IsNotNull(actual);
            Assert.AreEqual(ptid, actual.PlayerTypeID);
            Assert.AreEqual(name, actual.Name);
        }

        /*[TestMethod]
        [ExpectedException(typeof(RecordNotFoundException))]
        public void FetchPersonWithNonExistingIdShouldThrowRecordNotFoundException()
        {
            repo.FetchPerson(0);
        }

        [TestMethod]
        public void FetchPersonShouldWork()
        {
            var expected = CreateTestPerson();
            var actual = repo.FetchPerson(expected.PersonId);

            AssertPersonsAreEqual(expected, actual);
        }

        [TestMethod]
        public void GetPersonShouldWork()
        {
            var expected = CreateTestPerson();
            var actual = repo.GetPerson(expected.Email);

            AssertPersonsAreEqual(expected, actual);
        }

        [TestMethod]
        public void RetrievePersonsShouldWork()
        {
            var p1 = CreateTestPerson();
            var p2 = CreateTestPerson();
            var p3 = CreateTestPerson();

            var expected = new Dictionary<int, Person>
         {
            { p1.PersonId, p1 },
            { p2.PersonId, p2 },
            { p3.PersonId, p3 }
         };

            var actual = repo.RetrievePersons();

            Assert.IsNotNull(actual);
            Assert.IsTrue(actual.Count >= 3, "At least three are expected.");

            var matchCount = 0;

            foreach (var a in actual)
            {
                if (!expected.ContainsKey(a.PersonId))
                    continue;

                AssertPersonsAreEqual(expected[a.PersonId], a);

                matchCount += 1;
            }

            Assert.AreEqual(expected.Count, matchCount, "Not all expected persons were returned.");
        }

        private static void AssertPersonsAreEqual(Person expected, Person actual)
        {
            Assert.IsNotNull(actual);
            Assert.AreEqual(expected.FirstName, actual.FirstName);
            Assert.AreEqual(expected.LastName, actual.LastName);
            Assert.AreEqual(expected.Email, actual.Email);
        }*/

        private Player CreateTestPerson()
        {
            return repo.CreatePlayer(PlayerType.Midfielder, GetTestString());
        }
    }
}
