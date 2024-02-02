CREATE TABLE users
(
  log_id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  user_name VARCHAR(50) NOT NULL,
  password VARCHAR(255) NOT NULL,
  user_type VARCHAR(20) NOT NULL
);

CREATE TABLE receptionist
(
  receptionist_id INT PRIMARY KEY,
  receptionist_name VARCHAR(255) NOT NULL,
  sex CHAR(1) NOT NULL,
  salary DOUBLE PRECISION NOT NULL,
  phone_no VARCHAR(15) NOT NULL,
  log_id INT NOT NULL,
  FOREIGN KEY (log_id) REFERENCES users(log_id)
);

CREATE TABLE janitor
(
  janitor_id INT PRIMARY KEY,
  janitor_name VARCHAR(255) NOT NULL,
  sex CHAR(1) NOT NULL,
  phone_no VARCHAR(15) NOT NULL
);

CREATE TABLE nurse
(
  nurse_id INT PRIMARY KEY,
  nurse_name VARCHAR(255) NOT NULL,
  nurse_phone_no VARCHAR(15) NOT NULL,
  sex CHAR(1) NOT NULL,
  salary DOUBLE PRECISION NOT NULL,
  log_id INT NOT NULL,
  FOREIGN KEY (log_id) REFERENCES users(log_id)
);

CREATE TABLE doctor
(
  doctor_id INT PRIMARY KEY,
  dname VARCHAR(255) NOT NULL,
  specialty VARCHAR(255) NOT NULL,
  d_contact_no VARCHAR(15) NOT NULL,
  doctor_in TIME NOT NULL,
  doctor_out TIME NOT NULL,
  log_id INT NOT NULL,
  FOREIGN KEY (log_id) REFERENCES users(log_id)
);

CREATE TABLE room
(
  room_id INT PRIMARY KEY,
  room_type VARCHAR(255) NOT NULL,
  room_status VARCHAR(255) NOT NULL,
  janitor_id INT NOT NULL,
  FOREIGN KEY (janitor_id) REFERENCES janitor(janitor_id)
);

CREATE TABLE patient
(
  patient_id INT PRIMARY KEY,
  p_contact_no VARCHAR(15) NOT NULL,
  address VARCHAR(255) NOT NULL,
  sex CHAR(1) NOT NULL,
  pname VARCHAR(255) NOT NULL,
  dob DATE NOT NULL,
  room_id INT NOT NULL,
  FOREIGN KEY (room_id) REFERENCES room(room_id)
);

CREATE TABLE registration
(
  reg_no INT PRIMARY KEY,
  patient_id INT NOT NULL,
  in_date DATE,
  out_date DATE,
  discharge BOOLEAN NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE medical_record
(
  mr_no INT PRIMARY KEY,
  date DATE NOT NULL,
  diagnosis VARCHAR(255) NOT NULL,
  doctor_id INT NOT NULL, 
  reg_no INT NOT NULL,
  receptionist_id INT NOT NULL,
  FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
  FOREIGN KEY (reg_no) REFERENCES registration(reg_no),
  FOREIGN KEY (receptionist_id) REFERENCES receptionist(receptionist_id)
);

CREATE TABLE pharmacy
(
  drug_id INT PRIMARY KEY,
  drug_name VARCHAR(255) NOT NULL,
  dosage VARCHAR(50) NOT NULL,
  price INT NOT NULL,
  availability_ BOOLEAN NOT NULL,
  mr_no INT NOT NULL,
  FOREIGN KEY (mr_no) REFERENCES medical_record(mr_no)
);