import csv
from io import TextIOWrapper
from zipfile import ZipFile

# opens file for ALL tables.

uni_attributes = ["iau_id1", "eng_name", "orig_name", "foundedyr",
             "yrclosed", "private01", "latitude", "longitude", "phd_granting",
            "divisions", "specialized", "countrycode"]
country_attributes = ["countrycode", "country", "region", "incomegroup"]

admissions_attributes = ["iau_id1", "year", "students5_estimated"]


# process_file goes over all rows in original csv file, and sends each row to process_row()
def process_file():
    with ZipFile('enrollment.zip') as zf:
        with zf.open('enrollment.csv', 'r') as infile:
            reader = csv.DictReader(TextIOWrapper(infile, 'utf-8'))
            universities = {}
            countries = {}
            admissions = {}
            regions = set()
            incomegroups = set()
            for row in reader:
                # TO DO splits row into the different csv table files
                iau_id1 = row["iau_id1"]
                universities[iau_id1] = [row[i] for i in uni_attributes]
                countries[row["countrycode"]] = [row[i] for i in country_attributes]
                admissions[(row["iau_id1"], row["year"])] = [row[i] for i in
                                                             admissions_attributes]
                regions.add(row["region"])
                incomegroups.add(row["incomegroup"])
            with open('university.csv', 'w', newline='',
                      encoding='utf-8') as university_file:
                university_writer = csv.writer(university_file)
                university_writer.writerow(uni_attributes)
                for key in universities.values():
                    university_writer.writerow(key)
            with open('admissions.csv', 'w', newline='',
                      encoding='utf-8') as admissions_file:
                admissions_writer = csv.writer(admissions_file)
                admissions_writer.writerow(admissions_attributes)
                for key in admissions.values():
                    admissions_writer.writerow(key)
            with open('country.csv', 'w', newline='',
                      encoding='utf-8') as country_file:
                country_writer = csv.writer(country_file)
                country_writer.writerow(country_attributes)
                for key in countries.values():
                    country_writer.writerow(key)
            with open('region.csv', 'w', newline='',
                      encoding='utf-8') as region_file:
                region_writer = csv.writer(region_file)
                region_writer.writerow(["region"])
                for key in regions:
                    region_writer.writerow([key])
            with open('incomegroup.csv', 'w', newline='',
                      encoding='utf-8') as incomegroup_file:
                incomegroup_writer = csv.writer(incomegroup_file)
                incomegroup_writer.writerow(["incomegroup"])
                for key in incomegroups:
                    incomegroup_writer.writerow([key])



# return the list of all tables
def get_names():
    return ["region", "incomegroup", "university", "country", "admissions"]


if __name__ == "__main__":
    process_file()
