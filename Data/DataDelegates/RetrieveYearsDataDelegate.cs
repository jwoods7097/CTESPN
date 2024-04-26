using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class RetrieveYearsDataDelegate : DataReaderDelegate<IReadOnlyList<int>>
    {
        public RetrieveYearsDataDelegate() : base("MLS.RetrieveYears")
        { 
        }

        public override IReadOnlyList<int> Translate(Command command, IDataRowReader reader)
        {
            var p = new List<int>();

            while (reader.Read())
            {
                p.Add(reader.GetInt32("Year"));
            }

            return p;
        }
    }
}
