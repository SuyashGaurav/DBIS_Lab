import psycopg2

conn = psycopg2.connect(database='hospitaldb',
                        host="localhost",
                        user="postgres",
                        password="suyashgaurav72",
                        port=5432)

mycursor = conn.cursor()
query=0
while (query!=-1):
    query = int(input("Enter which query to execute (Enter -1 to exit): "))
    try:
        if query==-1:
            break
        if query == 1:
            # retrieve janitor name for a room number
            roomid = int(input("Enter room ID: "))
            line = f"SELECT janitor_name FROM janitor NATURAL JOIN room WHERE room_id={roomid}"
        elif query == 2:
            # retrieve room no. of patient
            patient_id = int(input("Enter patient ID: "))
            line = f"SELECT room_id FROM room NATURAL JOIN patient WHERE patient_id={patient_id}"
        elif query == 3:
            # retrieve patients of a doctor
            docid = int(input("Enter doctor ID: "))
            line = f"SELECT pname FROM patient NATURAL JOIN registration NATURAL JOIN medical_record NATURAL JOIN doctor WHERE doctor_id={docid}"
        elif query == 4:
            # retrieve diagnosis of a patient
            patient_id = int(input("Enter patient ID: "))
            line = f"SELECT diagnosis FROM medical_record NATURAL JOIN registration NATURAL JOIN patient WHERE patient_id={patient_id}"
        elif query == 5:
            # retrieve doctor of patient
            patient_id = int(input("Enter patient ID: "))
            line = f"SELECT dname FROM doctor NATURAL JOIN medical_record NATURAL JOIN registration NATURAL JOIN patient WHERE patient_id={patient_id}"
        elif query == 6:
            # retrieve discharge date of patient
            patient_id = int(input("Enter patient ID: "))
            line = f"SELECT out_date FROM registration NATURAL JOIN patient WHERE patient_id={patient_id}"
        elif query == 7:
            # retrieve medicine of patient
            patient_id = int(input("Enter patient ID: "))
            line = f"SELECT drug_name FROM pharmacy NATURAL JOIN medical_record NATURAL JOIN registration WHERE patient_id={patient_id}"
        elif query == 8:
            # retrieve all available drugs
            line = "SELECT drug_name FROM pharmacy WHERE availability_='t'"
        elif query == 9:
            # create new patient
            patient_id = int(input("Enter patient ID: "))
            p_contact_no = input("Enter patient contact number: ")
            address = input("Enter patient address: ")
            sex = input("Enter patient sex: ")
            pname = input("Enter patient name: ")
            dob = input("Enter patient date of birth: ")
            room_id = int(input("Enter room ID: "))
            line = f"INSERT INTO patient VALUES ({patient_id},'{p_contact_no}','{address}','{sex}','{pname}','{dob}',{room_id})"
            print("Inserted")
        elif query == 10:
            # create new receptionist account
            receptionist_id = int(input("Enter receptionist ID: "))
            receptionist_name = input("Enter receptionist name: ")
            sex = input("Enter receptionist sex: ")
            salary = float(input("Enter receptionist salary: "))
            r_contact_no = input("Enter receptionist contact number: ")
            log_id = int(input("Enter receptionist login ID: "))
            line = f"INSERT INTO receptionist VALUES ({receptionist_id},'{receptionist_name}','{sex}',{salary},'{r_contact_no}',{log_id})"
            print("Inserted")
        elif query == 11:
            # create new nurse account
            nurse_id = int(input("Enter nurse ID: "))
            nurse_name = input("Enter nurse name: ")
            nurse_phone_no = input("Enter nurse phone number: ")
            sex = input("Enter nurse sex: ")
            salary = float(input("Enter nurse salary: "))
            log_id = int(input("Enter nurse login ID: "))
            line = f"INSERT INTO nurse VALUES ({nurse_id},'{nurse_name}','{nurse_phone_no}','{sex}',{salary},{log_id})"
            print("Inserted")
        elif query == 12:
            # create new drug which has arrived
            drug_id = int(input("Enter drug ID: "))
            drug_name = input("Enter drug name: ")
            dosage = input("Enter drug dosage: ")
            price = float(input("Enter drug price: "))
            availability = input("Enter drug availability (t/f): ")
            mr_no = int(input("Enter medical record number: "))
            line = f"INSERT INTO pharmacy VALUES ({drug_id},'{drug_name}','{dosage}',{price},'{availability}',{mr_no})"
            print("Inserted")
        elif query == 13:
            # change receptionist phone number
            receptionist_id = int(input("Enter receptionist ID: "))
            phone = input("Enter new phone number: ")
            line = f"UPDATE receptionist SET phone_no='{phone}' WHERE receptionist_id={receptionist_id}"
            print("Updated")
        elif query == 14:
            # when patient is discharged
            patient_id = int(input("Enter patient ID: "))
            line = f"UPDATE registration SET discharge='true' WHERE patient_id={patient_id}"
            print("Updated")
        elif query == 15:
            # delete a patient
            patient_id = int(input("Enter patient ID to delete: "))
            line = f"DELETE FROM patient WHERE patient_id={patient_id}"
            print("Deleted")
        elif query == 16:
            # room is not usable
            room_id = int(input("Enter room ID to delete: "))
            line = f"DELETE FROM room WHERE room_id={room_id}"
            print("Deleted")
        elif query==17:
            mr_no = int(input("Enter medical record number to delete: "))
            line = f"DELETE FROM medical_record where mr_no={mr_no}"
            print("Deleted")
        mycursor.execute(line)
        if query<9:
            table=mycursor.fetchall()
            for row in table:
                print(row)
    except Exception as e:
        print("ERROR")
        print(e)

#transaction
print("Transaction")

try:
    patient_id =input("Enter patient ID: ")
    mycursor.execute(f"select * from registration where patient_id={patient_id}")
    if len(mycursor.fetchall())==0:
        print("patient doesn't exist")
    else:
        line = f"UPDATE registration SET discharge='true' WHERE patient_id={patient_id}"
        
        mycursor.execute("BEGIN;")
        mycursor.execute(line)
        mycursor.execute("COMMIT;")
        
        print("Transaction committed successfully")

except Exception as e:
    print(f"Error: {e}")
    mycursor.execute("ROLLBACK;")
    print("Transaction rolled back")

finally:
    mycursor.close()
    conn.close()





