#include <iostream>
#include <string>
#include <vector>
#include <libpq-fe.h>
using namespace std;

// Structure to hold query and its description
struct QueryInfo {
    string description;
    string query;
};

// Function to print query results
void printResults(PGresult* res) {
    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        cout << "Query failed: " << PQresultErrorMessage(res) << endl;
        return;
    }

    int rows = PQntuples(res);
    int cols = PQnfields(res);

    // Print column names
    cout << "\nColumns: ";
    for (int i = 0; i < cols; i++) {
        if (i > 0) cout << ", ";
        cout << PQfname(res, i);
    }
    cout << "\n\nResults:" << endl;

    // Print rows
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (j > 0) cout << "\t";
            cout << PQgetvalue(res, i, j);
        }
        cout << endl;
    }
}

int main() {
    // Initialize connection parameters
    const char* conninfo = "dbname=22CS30010 user=22CS30010 password=22CS30010 host=10.5.18.72 port=5432";
    
    // Connect to database
    PGconn* conn = PQconnectdb(conninfo);

    // Check connection status
    if (PQstatus(conn) != CONNECTION_OK) {
        cout << "Connection to database failed: " << PQerrorMessage(conn) << endl;
        PQfinish(conn);
        return 1;
    }

    cout << "Connected to database successfully!\n" << endl;

        // Vector of queries and their descriptions
        std::vector<QueryInfo> queries = {
            {
                "Citizens with more than 1 acre of land",
                "SELECT DISTINCT c.name "
                "FROM citizens c "
                "JOIN land_records lr ON c.citizen_id = lr.citizen_id "
                "WHERE lr.area_acres > 1;"
            },
            {
                "Girls in school with household income < 1 Lakh",
                "SELECT c.name "
                "FROM citizens c "
                "JOIN households h ON c.household_id = h.household_id "
                "WHERE c.gender = 'Female' "
                "AND c.educational_qualification IN ('Primary', 'Secondary', '10th', '12th') "
                "AND h.income < 100000;"
            },
            {
                "Total rice cultivation area",
                "SELECT SUM(lr.area_acres) AS total_rice_acres "
                "FROM land_records lr "
                "WHERE lr.crop_type = 'Rice';"
            },
            {
                "Citizens born after 2000 with 10th class qualification",
                "SELECT COUNT(*) AS total_citizens "
                "FROM citizens "
                "WHERE dob > '2000-01-01' "
                "AND educational_qualification = '10th';"
            },
            {
                "Panchayat employees with more than 1 acre land",
                "SELECT c.name "
                "FROM panchayat_employees pe "
                "JOIN citizens c ON pe.citizen_id = c.citizen_id "
                "JOIN land_records lr ON c.citizen_id = lr.citizen_id "
                "WHERE lr.area_acres > 1;"
            },
            {
                "Household members of Panchayat Pradhan",
                "SELECT c.name "
                "FROM citizens c "
                "JOIN households h ON c.household_id = h.household_id "
                "WHERE h.household_id = ("
                "    SELECT h.household_id "
                "    FROM panchayat_employees pe "
                "    JOIN citizens c ON pe.citizen_id = c.citizen_id "
                "    WHERE pe.role = 'Pradhan'"
                ");"
            },
            {
                "Street lights in Phulera installed in 2024",
                "SELECT COUNT(*) AS total_street_lights "
                "FROM assets "
                "WHERE type = 'Street Light' "
                "AND location = 'Phulera' "
                "AND EXTRACT(YEAR FROM installation_date) = 2024;"
            },
            {
                "Vaccinations in 2024 for children of 10th pass citizens",
                "SELECT COUNT(*) AS total_vaccinations "
                "FROM vaccinations v "
                "JOIN citizens c ON v.citizen_id = c.citizen_id "
                "WHERE EXTRACT(YEAR FROM v.date_administered) = 2024 "
                "AND c.educational_qualification = '10th' "
                "AND AGE(c.dob) < INTERVAL '18 years';"
            },
            {
                "Boy births in 2024",
                "SELECT COUNT(*) AS total_boy_births "
                "FROM census_data cd "
                "JOIN citizens c ON cd.citizen_id = c.citizen_id "
                "WHERE cd.event_type = 'Birth' "
                "AND c.gender = 'Male' "
                "AND EXTRACT(YEAR FROM cd.event_date) = 2024;"
            },
            {
                "Citizens in panchayat employee households",
                "SELECT COUNT(DISTINCT c.citizen_id) AS total_citizens "
                "FROM citizens c "
                "WHERE c.household_id IN ("
                "    SELECT DISTINCT h.household_id "
                "    FROM households h "
                "    JOIN panchayat_employees pe ON h.household_id = ("
                "        SELECT household_id "
                "        FROM citizens "
                "        WHERE citizen_id = pe.citizen_id"
                "    )"
                ");"
            }
        };
    // Execute each query
    for (const auto& queryInfo : queries) {
        cout << "\n================================================" << endl;
        cout << queryInfo.description << endl;
        cout << "================================================" << endl;

        // Execute query
        PGresult* res = PQexec(conn, queryInfo.query.c_str());
        
        // Print results
        printResults(res);
        
        // Free result
        PQclear(res);
    }

    // Close database connection
    PQfinish(conn);
    cout << "\nDatabase connection closed." << endl;

    return 0;
}