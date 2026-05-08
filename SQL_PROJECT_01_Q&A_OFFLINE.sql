use hotelsalesdb;

SET SQL_SAFE_UPDATES = 0;

-- Question - 1] The accounts team wants to check payments made via UPI to measure digital adoption.
 SELECT * FROM payments
WHERE PaymentMethod = 'UPI';

-- Question - 2] List all unique first names of customers for a duplicate check.??
SELECT distinct FirstName from customers;

-- Question - 3] Delete all rooms with Capacity = 1. 
SET SQL_SAFE_UPDATES = 0;
DELETE FROM rooms
WHERE capacity = 1;


-- Question - 4] Display each customer’s name and phone number together using CONCAT. 
SELECT CONCAT(FirstName, ' ', LastName, ' - ', Phone) AS customer_details
FROM customers;


-- Question - 5] The booking office wants to see bookings where RoomID = 10 to check utilization 
-- of a specific room. 
select * from BOOKINGS WHERE RoomID=10;


-- Question - 6] Identify rooms whose Capacity is greater than the average Capacity of all rooms.
select * from rooms
where Capacity > (select avg(Capacity) from rooms);


-- Question - 7] Create a VIEW StaffContact showing Staff FirstName, LastName, Role, and Phone
CREATE VIEW StaffContact as
select FirstName, LastName, Role, Phone from staff;


-- Question - 8] The receptionist wants to offer Suite rooms under ₹7000 to business travelers. 
select * from rooms
where RoomType='Suite' and PricePerNight<7000;


-- Question - 9] The admin wants to see email addresses sorted by LastName from the Customers 
select Email from customers
order by Lastname;


-- Question - 10] Show staff full names combined into one column. 
select concat(FirstName, ' ', LastName) as Fullname from staff;

-- Question - 11] Display all payment details in one line using CONCAT_WS. 
select CONCAT_WS(' | ', PaymentID, BookingID, PaymentDate, PaymentMethod, Amount) from payments;


-- Question - 12] The hotel wants to display the 2 most expensive rooms for VIP guests. 
select * from rooms
order by PricePerNIght desc limit 1;


-- Question - 13] Show each BookingID with its CheckIn and CheckOut dates combined. 
select BookingID, concat_ws('to', CheckInDate, ' ', CheckOutDate) as BookingDetails from bookings;



-- Question - 14] Finance wants to calculate the average Amount per PaymentMethod. 
select paymentmethod, avg(Amount) as Averageamount from payments
group by paymentmethod
order by avg(Amount);


-- Question - 15] The analytics team wants to find the city where average CustomerID is greater than 50
select city, avg(customerid) as Avg_CustomerID from customers
group by city
having avg(customerid)>50;


-- Question - 16] Find bookings where TotalAmount exceeds the average TotalAmount. (Bookings subquery)  
select bookingid, totalamount from bookings
where totalamount > (select avg(totalamount) from bookings);


-- Question - 17] Display the last 2 added rooms from the Rooms table. 
select * from rooms
order by roomid desc limit 2;


-- Question - 18] The cashier wants a report of payments where Amount < ₹1500 for small transactions
select * from payments
where amount < 1500;


-- Question - 19] Management wants to list all customers who have made more than 5 bookings. 
select * from bookings
where customerID in (select customerid from bookings
group by customerid
having count(*)>5);


-- Question - 20] Identify customers who live in the same city. (Customers self join) 
select * from customers
order by city;


-- Question - 21] Show the total revenue handled by each StaffID. 
select staffid, sum(totalamount) as totalrevenue from bookings
group by staffid
order by sum(totalamount) desc;


-- Question - 22] The manager wants to see all customers from Mumbai to check city-wise marketing campaigns.
select customerid, firstname, lastname from customers
where city='Mumbai';


-- Question - 23] Display the 3 lowest booking amounts. 
select * from bookings
order by totalamount asc limit 3;


-- Question - 24] Insert 5 new room records with type, price, and capacity into the Rooms table. 
INSERT INTO rooms (room_name, price, capacity)
VALUES 
('Deluxe Room', 4500, 2),
('Executive Suite', 7500, 3),
('Presidential Suite', 15000, 5),
('Business Room', 6000, 2),
('Family Suite', 9000, 4);


-- Question - 25] Show all unique CustomerIDs from bookings. 
select distinct customerid from bookings;

-- Question - 26] Create a trigger to automatically delete a payment when its corresponding booking is deleted. 
DELIMITER $$

CREATE TRIGGER delete_payment_after_booking
AFTER DELETE ON bookings
FOR EACH ROW
BEGIN
    DELETE FROM payments
    WHERE bookingid = OLD.bookingid;
END$$

DELIMITER ;



-- Question - 27] The marketing team wants to update the FirstName of CustomerID = 30 to Rahul'.
UPDATE customers
SET firstname = 'Rahul'
WHERE customerid = 30;


-- Question - 28] List all bookings ordered by CheckInDate. 
select * from bookings
order by CheckInDate;


-- Question - 29] Show all rooms where capacity is greater than 2. 
select * from rooms where capacity >2;


-- Question - 30] List staff emails ordered by their roles. 
select firstname, lastname, email, role from staff
order by role;


-- Question - 31] Display each customer’s full name and city using CONCAT_WS. 
select CONCAT_WS('  ', firstname, lastname) as FullName, city from customers;


-- Question - 32] Show the first 4 customers’ full names only. 
select CONCAT_WS('  ', firstname, lastname) as FullName from customers limit 4;


-- Question - 33] Show each staff’s role with their full name. 
select role, CONCAT_WS('  ', firstname, lastname) as FullName from staff
order by role;


-- Question - 34] Management wants to find the average StaffID per role. 
select role, avg(staffid) as averageofsatff from staff
group by role
order by role;


-- Question - 35] List all bookings handled by StaffID = 2. 
select * from bookings
where staffid=2;

-- Question - 36] Display the first 3 staff alphabetically by their first names. 
select * from staff limit 3;


-- Question - 37] The front desk manager wants to see customers where FirstName = 'Amit' AND 
-- City = 'Nagpur' for personal attention. 
select * from customers
where FirstName = 'Amit' AND City = 'Nagpur';


-- Question - 38] Show all unique payment methods in descending order. 
select distinct paymentmethod from payments;


-- Question - 39] Insert 5 staff members into the Staff table with their role, phone, and email. 
INSERT INTO staff (firstname, lastname, role, Phone, email)
VALUES
('Neha', 'Singh', 'Admin', '9876543210', 'neha.singh@hotel.com'),
('Raj', 'Mehta', 'Cashier', '9123456789', 'raj.mehta@hotel.com'),
('Priya', 'Sharma', 'Manager', '9988776655', 'priya.sharma@hotel.com'),
('Amit', 'Kumar', 'Chef', '9765432109', 'amit.kumar@hotel.com'),
('Sneha', 'Patil', 'Receptionist', '9345678901', 'sneha.patil@hotel.com');


-- Question - 40] The hotel manager wants to review bookings where CheckInDate is after '2024
-- 01-01' to analyze recent occupancy. 
select * from bookings
where CheckInDate>'2024-01-01'
order by CheckInDate;


-- Question - 41] List all customers whose FirstName is 'Rahul' for a loyalty program. 
select * from customers
where FirstName='Rahul';


-- Question - 42] Show all unique room types offered by the hotel. 
select distinct RoomType from rooms;


-- Question - 43] Identify customers who spent more than 50,000 in total. 
select customerid, totalamount from bookings
where totalamount > 50000;


-- Question - 44] Delete all customers from the city 'TestCity'. 
delete from customers
where city='TestCity';


-- Question - 45] Find rooms that have the same PricePerNight. (Rooms self join) 
SELECT r1.RoomID, r1.RoomType, r1.PricePerNight,
       r2.RoomID AS OtherRoomID, r2.RoomType AS OtherRoomType
FROM Rooms r1
JOIN Rooms r2
  ON r1.PricePerNight = r2.PricePerNight
 AND r1.RoomID < r2.RoomID
ORDER BY r1.PricePerNight;



-- Question - 46] The manager wants to see staff whose Email ends with '@tcs.in' for corporate tie
-- ups
select * from customers
where Email like '%@tcs.in';


-- Question - 47] The analytics team wants to list all cities where maximum CustomerID is more 
-- than 100. 
select city from customers
where CustomerID > 100;


-- Question - 48] Show all unique capacities in descending order. 
select distinct capacity from rooms 
order by capacity desc;


-- Question - 49] List staff working as Managers. 
select role from staff
where role=	'Managers';


-- Question - 50] Display each payment’s ID, Method, Amount in one line. 
SELECT CONCAT_WS(' - ', 
       paymentid, 
       paymentmethod, 
       amount) AS payment_summary
FROM Payments;


-- Question - 51] Show the first 4 payments only. 
select * from payments limit 4;


-- Question - 52] The hotel manager wants to review rooms where PricePerNight is between ₹2000 
-- and ₹4000 to offer discounts. 
select * from rooms
where PricePerNight between 2000 and 4000;



-- Question - 53] List all bookings ordered by CheckInDate. 
select * from bookings
order by CheckInDate;


-- Question - 54] Display all unique CustomerIDs from bookings. 
select distinct CustomerID from bookings;


-- Question - 55] The hotel manager wants to add new customer details. Insert 5 records with full 
-- details into the Customers table. 
INSERT INTO Customers (firstname, lastname, email, phone, city)
VALUES
('Rohan', 'Desai', 'rohan.desai@example.com', '9876543210', 'Mumbai'),
('Sneha', 'Patil', 'sneha.patil@example.com', '9123456789', 'Pune'),
('Amit', 'Sharma', 'amit.sharma@example.com', '9988776655', 'Nagpur'),
('Priya', 'Mehta', 'priya.mehta@example.com', '9765432109', 'Delhi'),
('Neha', 'Kapoor', 'neha.kapoor@example.com', '9345678901', 'Bangalore');


-- Question - 56] Show the last 2 staff hired. 
select * from staff
order by staffid desc limit 2;



-- Question - 57] Identify rooms with PricePerNight higher than the maximum PricePerNight of 
-- rooms with Capacity = 2. (Rooms subquery) 
select * from rooms
where PricePerNight > (select max(PricePerNight)
where Capacity = 2);



-- Question - 58] The HR team wants to see staff whose Role is not 'Chef' for role reallocation. 
select * from staff
where role!='Chef';


-- Question - 59] Show all unique cities in descending order from the Customers table. 
select distinct city from customers;


-- Question - 60] Display the phone number of the Waiter only. 
select role, phone from staff
where role = 'Waiter';


-- Question - 61] Display the last 2 bookings in the table. 
select * from bookings
order by bookingid desc limit 2;


-- Question - 62] The marketing team wants to see customers living in Delhi or Chennai for 
-- targeted promotions. 
select * from customers
where city in ('Delhi' or 'Chennai');


-- Question - 63] Show all rooms where RoomType != 'Family' to plan renovations. 
select * from rooms
where RoomType != 'Family';


-- Question - 64] List staff emails ordered by their roles. 
select Email from staff
order by role;


-- Question - 65] Display all unique payment methods. 
select distinct paymentmethod from payments;

-- Question - 66] The receptionist wants a list of customers whose Phone starts with '98' for mobile offers
select * from staff
where phone like '98%';


-- Question - 67] Show the 3 cheapest rooms available for budget travelers. 
select * from rooms
order by pricepernight
limit 3;


-- Question - 68] Display the last 2 payments. 
select * from payments
order by paymentid desc
limit 2;


-- Question - 69] Management wants to know which unique cities customers come from. 
select distinct city from customers;

-- Question - 70] List all bookings where TotalAmount > 5000. 
select * from bookings
where TotalAmount > 5000;


-- Question - 71] Display each staff’s Role with their Email in one column. 
select concat_ws(' | ', Role, Email) as Details from staff;


-- Question - 72] Show the first 4 staff full names. 
select concat(firstname, ' ', lastname)as fullname from staff
limit 4;


-- Question - 73] Find bookings where TotalAmount is greater than all bookings made by 
-- CustomerID = 10. (Bookings subquery) 
select * from bookings
where TotalAmount > all(select TotalAmount from bookings
where CustomerID = 10);


-- Question - 74] List rooms with capacity >= 3 for family bookings. 
select * from rooms
where capacity >=3;


-- Question - 75] Display the RoomType and Price of only Suite rooms. 
select RoomType, PriceperNight from rooms
where RoomType= 'Suite';


-- Question - 76] The cashier wants to see payments with Amount between ₹2000 and ₹7000 for 
-- mid-range billing checks. 
select * from payments
where Amount between 2000 and 7000;


-- Question - 77] Insert 5 booking records into the Bookings table with all details. 



-- Question - 78] Display the 3 lowest payments made by customers. 
select * from payments
order by amount limit 3;


-- Question - 79] Show each booking’s BookingID with TotalAmount using CONCAT. 
select concat(BookingID, ' ', TotalAmount) as BookingDetailswithAmount from bookings;


-- Question - 80] Show all unique RoomIDs in descending order. 
select distinct RoomID from rooms;

-- Question - 81] Display each room’s RoomType and Price using CONCAT_WS. 
select concat_ws(' | ', RoomType, Pricepernight) as Priceasroom from rooms;


-- Question - 82] The admin wants to delete all bookings handled by StaffID = 3. 
delete from staff
where staffid=3;


-- Question - 83] Show customers whose FirstName length > 5 characters for a name-pattern study
SELECT *
FROM Customers
WHERE LENGTH(FirstName) > 5;


-- Question - 84] Show all unique roles available in the hotel. 
select distinct role from staff;

-- Question - 85] List all rooms where capacity is greater than 2. 
select * from rooms
where capacity>2;

-- Question - 86] Display each payment’s ID with Amount using CONCAT. 
select concat_ws(' | ', paymentid, amount) as Amount_with_payment from payments;


-- Question - 87] List all Card payments from the Payments table. 
select * from payments
where paymentmethod = 'Card';


-- Question - 88] Delete all customers whose Email ends with '@test.com' as invalid. 
delete from customers
where email like '%@test.com';


-- Question - 89] The hotel manager wants to review bookings where CheckOutDate before '2023
-- 12-31' to measure old occupancy. 
select * from bookings
where CheckOutDate < '2023-12-31';


-- Question - 90] The front office manager needs to list rooms with capacity = 2 for couples. 
select * from rooms
where capacity = 2;


-- Question - 91] Show all unique capacities in descending order. 
select distinct Capacity from rooms
order by capacity desc;


-- Question - 92] The operations team wants to find the minimum TotalAmount in bookings. 
select min(TotalAmount) from bookings;

-- Question - 93] Display all rooms by capacity in ascending order. 
select * from rooms
order by capacity desc;

-- Question - 94] Show each booking’s BookingID with TotalAmount using CONCAT. 
select concat(BookingID, ' ', TotalAmount) as BookingAmount from bookings;


-- Question - 95] The operations head wants to see rooms with Capacity = 4 AND PricePerNight > 
-- ₹6000 for premium family packages. 
select * from rooms
where Capacity = 4 AND PricePerNight > 6000;


-- Question - 96] Show staff full names combined into one column. 
select concat_ws(' _ ', firstname, lastname) as FullName from staff;

-- Question - 97] The accounts team wants to see bookings where the TotalAmount is greater than 
-- ₹10,000 to track high-value customers. 
select * from bookings
where TotalAmount>10000;


-- Question - 98] Show all unique payment methods in descending order. 
select distinct paymentmethod from payments;


-- Question - 99] List staff members who share the same Role. (Staff self join) 
SELECT s1.StaffID AS Staff1_ID,
       CONCAT_WS(' ', s1.FirstName, s1.LastName) AS Staff1_Name,
       s2.StaffID AS Staff2_ID,
       CONCAT_WS(' ', s2.FirstName, s2.LastName) AS Staff2_Name,
       s1.Role
FROM Staff s1
JOIN Staff s2
  ON s1.Role = s2.Role
 AND s1.StaffID < s2.StaffID
ORDER BY s1.Role, s1.StaffID, s2.StaffID;


-- Question - 100] Show customer first name, last name, and TotalAmount of their bookings using 
-- JOIN between Customers and Bookings. 
SELECT c.CustomerID,
       c.FirstName,
       c.LastName,
       b.TotalAmount
FROM Customers c
JOIN Bookings b
  ON c.CustomerID = b.CustomerID
ORDER BY c.CustomerID, b.TotalAmount DESC;


-- Question - 101] Display the first 4 bookings only. 
select * from bookings limit 4;

-- Question - 102] Show all unique staff first names. 
select distinct firstname from staff;

-- Question - 103] Insert 5 new room records with type, price, and capacity into the Rooms table. 
INSERT INTO Rooms (RoomType, PricePerNight, Capacity)
VALUES
('Deluxe Room', 4500, 2),
('Executive Suite', 7500, 3),
('Presidential Suite', 15000, 5),
('Business Room', 6000, 2),
('Family Suite', 9000, 4);


-- Question - 104] Display each customer’s full name and city using CONCAT_WS. 
select concat(firstname, ' ', lastname) as Fullname, city from
customers;


-- Question - 105] Show all unique cities in descending order from the Customers table. 
select distinct city from customers
order by city desc;


-- Question - 106] The analytics team wants to list all cities where maximum CustomerID is more than 100.
SELECT City,
       MAX(CustomerID) AS MaxCustomerID
FROM Customers
GROUP BY City
HAVING MAX(CustomerID) > 100;


-- Question - 107] The HR team wants to see staff whose FirstName is 'Priya' for employee recognition
select firstname from customers
where firstname='Priya';

select firstname from staff
where firstname='Priya';


-- Question - 108] Display the last 2 staff members from the Staff table. 
select * from staff
order by staffid desc limit 2;


-- Question - 109] Create a VIEW BookingSummary showing BookingID, CustomerID, RoomID, and TotalAmount. 
CREATE VIEW BookingSummary AS
SELECT BookingID,
       CustomerID,
       RoomID,
       TotalAmount
FROM Bookings;


-- Question - 110] Show all unique RoomIDs in descending order. 
select distinct roomid from rooms
order by roomid desc;


-- Question - 111] Display each staff’s role with their full name. 
SELECT Role,
       CONCAT_WS(' ', FirstName, LastName) AS FullName
FROM Staff
ORDER BY Role;


-- Question - 112] The receptionist wants to offer Suite rooms under ₹7000 to business travelers. 
select RoomType, PricePerNight from rooms
where RoomType = 'Suite' and PricePerNight < 7000;


-- Question - 113] Display the first 3 staff alphabetically by their first names. 
select * from staff
order by firstname asc limit 3;


-- Question - 114] List all bookings ordered by CheckInDate. 
select * from bookings
order by CheckInDate;


-- Question - 115] Show all unique StaffIDs from the bookings. 
select distinct StaffID from bookings;


-- Question - 116] Display the first 4 customers’ full names only. 
select concat(Firstname, ' ', Lastname) as FullName from customers
limit 4;


-- Question - 117] Show all unique room types offered by the hotel. 
select distinct RoomType from rooms;


-- Question - 118] Display the phone number of the Waiter only. 
select role, phone from staff
where role = "Waiter";


-- Question - 119] Show all bookings where TotalAmount > 5000. 
select * from bookings
where totalamount > 5000;


-- Question - 120] The HR team wants to update Role = 'Senior Manager' where StaffID = 12. 
update staff
set role = 'Senior Manager' where staffid = 12;


-- Question - 121] List all staff working as Managers. 
select staffid, concat(firstname, ' ', lastname) as Fullname, role from staff
where role='manager';


-- Question - 122] Show the last 2 registered customers for follow-up. 
select * from customers
order by customerid desc limit 2;


-- Question - 123] Display each booking’s BookingID with TotalAmount using CONCAT. 
select concat(bookingid, ' ', totalamount) as Booking_TotalAmount from bookings;


-- Question - 124] Insert 5 staff members into the Staff table with their role, phone, and email. 
insert into staff (firstname,lastname, role, phone, email)
values ('Siddhesh', 'Gavare', 'Security', 7840958235, 'smg@gmail.com'),
	   ('Gaurav', 'Khan', 'Security', 7642658965, 'fsj@gmail.com'),
       ('Sahil', 'Poll', 'Security', 7766992543, 'pqr@gmail.com'),
       ('Vivek', 'Chadda', 'Security', 8852346189, 'abc@gmail.com'),
       ('Ram', 'Kapur', 'Security', 9854365821, 'lmn@gmail.com');
       
       
-- Question - 125] Display the RoomType and Price of only Suite rooms. 
select RoomType, PricePerNight from rooms
where RoomType = 'Suite';


-- Question - 126] The admin wants to delete all payments linked to BookingID = 15. 
delete from payments
where BookingID = 15;


-- Question - 127] Display all unique capacities in descending order. 
select distinct capacity from rooms
order by capacity desc;


-- Question - 128] Show the first 4 rooms sorted alphabetically by RoomType. 
select * from rooms
order by roomtype asc limit 4;


-- Question - 129] The cashier wants a report of payments where Amount < ₹1500 for small transactions
select * from payments
where Amount < 1500;


-- Question - 130] Show each booking’s BookingID with TotalAmount using CONCAT. 
select concat(bookingid, ' ', totalamount) as Booking_TotalAmount from bookings;


-- Question - 131] Display the last 2 added rooms from the Rooms table. 
select * from rooms
order by roomid desc limit 2;


-- Question - 132] List all customers whose FirstName = 'Amit' AND City = 'Nagpur' for personal attention
select * from customers
where FirstName = 'Amit' and City = 'Nagpur';


-- Question - 133] Insert 5 new customer details into the Customers table. 
insert into customers (firstname, lastname, email, phone, city)
values ('Siddhesh', 'Gavare', 'smg@gmail.com',7840958235, 'Malvan' ),
	   ('Gaurav', 'Khan', 'fsj@gmail.com',4652358965, 'Kudal'),
       ('Sahil', 'Poll', 'pqr@gmail.com',9854125632, 'Goa'),
       ('Vivek', 'Chadda', 'abc@gmail.com',9756425328, 'Kochi'),
       ('Ram', 'Kapur','lmn@gmail.com',8823564723, 'Panaji');
       
       
-- Question - 134] Show staff full names combined into one column. 
select concat_ws(' | ', Firstname, Lastname) as Staff_Fullname from staff;


-- Question - 135] Show all room details separated by commas using CONCAT_WS. 
select concat_ws(' , ', roomid, roomtype, pricepernight, capacity) as Room_Details
from rooms;


-- Question - 136] Display each customer’s name and phone number together using CONCAT. 
select concat(' ', firstname, lastname) as Fullname, phone from customers;


-- Question - 137] Display all payment details in one line using CONCAT_WS. 
select concat_ws(' ', paymentid, bookingid, paymentdate, paymentmethod, amount) as payment_details from payments;


-- Question - 138] Show the last 2 bookings in the table. 
select * from bookings
order by bookingid desc limit 2;

-- Question - 139] List all payments ordered by PaymentDate. 
select paymentid, paymentdate from payments
order by paymentdate;

-- Question - 140] Show the 2 highest payments received. 
select * from payments
order by amount desc limit 2;


-- Question - 141] The marketing team wants to check customers whose FirstName is 'Rahul' for a loyalty program. 
select * from customers
where FirstName = 'Rahul';


-- Question - 142] Display each PaymentID with its method using CONCAT. 
select concat_ws(' | ', PaymentID, paymentMethod) as Details_of_Payments from payments;


-- Question - 143] The operations team wants to list all PaymentMethods used more than 5 times. 
select PaymentMethod, count(*) as countt from payments
group by PaymentMethod
having count(*)>5;


-- Question - 144] Show the 2 most expensive rooms for VIP guests. 
select * from rooms
order by pricepernight desc limit 2;


-- Question - 145] Show each room’s RoomType and Price using CONCAT_WS. 
select concat(RoomType, ' , ', PricePerNight) as Price_of_RoomType from rooms;


-- Question - 146] Display the first 3 staff alphabetically by their first names. 
select firstname from staff
order by firstname asc;


-- Question - 147] List all bookings handled by StaffID = 2. 
select * from bookings
where StaffID = 2;


-- Question - 148] The analytics team wants to find the city where average CustomerID is greater than 50. 
select city, avg(customerid) as AverageCustomerID from customers
group by city
having avg(customerid)>50;


-- Question - 149] The hotel wants to display the 2 most expensive rooms for VIP guests. 
select * from rooms
order by Pricepernight desc limit 2;

-- Question - 150] Show all unique first names of customers for a duplicate check. 
select distinct firstname from customers;


-- Question - 151] Show all unique roles in descending order. 
select role from staff
order by role desc;


-- Question - 152] Identify rooms whose Capacity is greater than the average Capacity of all rooms. (Rooms subquery) 
select * from rooms
where capacity > (select avg(capacity) from rooms);


-- Question - 153] Display all rooms by capacity in ascending order. 
select roomtype, capacity from rooms
order by capacity asc;


-- Question - 154] Display the first 4 payments only. 
select * from payments
order by paymentid asc limit 4;


-- Question - 155] Show each payment’s ID, Method, Amount in one line. 
select concat_ws(' | ', paymentid, paymentmethod, amount) as payment_details from payments;


-- Question - 156] List all bookings where TotalAmount > 5000. 
select * from bookings
where TotalAmount > 5000;


-- Question - 157] Find all customers whose CustomerID is greater than the average CustomerID. (Customers subquery) 
select customerid from customers
where customerid > (select avg(customerid) from customers);


-- Question - 158] The HR manager wants to see staff whose Role is not 'Chef' for role reallocation. 
select * from staff
where role != 'Cheff';


-- Question - 159] The accounts team wants to check bookings where TotalAmount is greater than ₹10,000. 
select * from bookings
where TotalAmount > 10000;

-- Question - 160] Display each staff’s role with their full name. 
select role, concat(firstname, '  ', lastname) as FullName from staff;


-- Question - 161] List staff members who share the same Role. (Staff self join) 
select concat(s1.firstname, ' ', s1.lastname)as Staff1, concat(s2.firstname, ' ', s2.lastname)as Staff2, s1.role from staff s1
join staff s2 on s1.role = s2.role
where s1.staffid=s2.staffid;


-- Question - 162] Show Customer Name and Payment Amount by joining Customers, Bookings, and Payments. 
select c.firstname, c.lastname, p.amount as payment_amount from customers c
join bookings b on c.customerid = b.customerid
join payments p on p.bookingid = b.bookingid;


-- Question - 163] Display all bookings where TotalAmount > 5000. 
select * from bookings
where TotalAmount > 5000;


-- Question - 164] The front desk wants to see customers whose Phone starts with '98'. 
select concat(firstname, '  ', lastname) as CustomersName, phone from staff
where phone like '98%';


-- Question - 165] Identify customers who live in the same city. (Customers self join) 
select concat(c1.firstname, '  ', c1.lastname) as customer1, concat(c2.firstname, '  ', c2.lastname) as customer2, c1.city from customers c1
join customers c2 on c1.city=c2.city and c1.customerid<c2.customerid;



-- Question - 166] The operations manager wants to check bookings with CheckOutDate before  '2023-12-31'. 
select * from bookings
where CheckOutDate < '2023-12-31';


-- Question - 167] Display all unique StaffIDs from the bookings. 
select distinct staffid from staff;


-- Question - 168] Create a VIEW OnlinePayments showing all payments made by PaymentMethod = 'Online'. 
create view OnlinePayments as
select * from payments
where PaymentMethod = 'Online';


-- Question - 169] Display all unique payment methods in descending order. 
select distinct paymentmethod from payments;


-- Question - 170] Display each payment’s ID with Amount using CONCAT. 
select concat(paymentid, '  ', amount) as Onlineamount from payments;


-- Question - 171] Show all unique RoomIDs in descending order. 
select distinct roomid from rooms
order by roomid desc;


-- Question - 172] The analytics team wants to list all cities where maximum CustomerID is more than 100. 
select city, count(customerid) as customer_count from customers
group by city
having count(customerid) >100;


-- Question - 173] List staff emails ordered by their roles. 
 select concat(firstname, '  ', lastname) as Fullname, email, role from staff
 order by role;
 
 
--  Question - 174] Find bookings where TotalAmount exceeds the average TotalAmount. (Bookings subquery) 
select * from bookings
where TotalAmount > (select avg(TotalAmount) from bookings);


-- Question - 175] Show all rooms where PricePerNight > ₹5000 for premium customer recommendations
select * from rooms
where PricePerNight > 5000;



-- Question - 176] Show all unique capacities in descending order. 
select distinct capacity from rooms
order by capacity desc;


-- Question - 177] Display the first 4 rooms sorted alphabetically by RoomType. 
select roomtype from rooms
order by roomtype asc limit 4;


-- Question - 178] Show all unique staff first names. 
select distinct firstname from staff;


-- Question - 179] Identify rooms with PricePerNight higher than the maximum PricePerNight of rooms with Capacity = 2. (Rooms subquery) 
select * from rooms
where PricePerNight > (select max(PricePerNight) where capacity=2);


-- Question - 180] Show all unique cities in descending order from the Customers table. 
select distinct city from customers
order by city desc;


-- Question - 181] List all bookings where TotalAmount > 5000. 
select * from bookings
where TotalAmount > 5000;


-- Question - 182] Show PaymentID, Customer Name, and BookingID for payments made using 'Credit Card'.
select p.paymentid, concat(c.firstname, ' ', c.lastname) as Fullname, p.bookingid from payments p
join customers c on c.customerid=p.customerid
where p.paymentmethod =  'Credit Card';



-- Question - 183] Display each booking’s BookingID with TotalAmount using CONCAT. 
select concat(bookingid, '  ', totalamount) as BookingAmount from bookings;


-- Question - 184] Show all bookings handled by StaffID = 2. 
select * from bookings where staffid =2;


-- Question - 185] Display the last 2 added rooms from the Rooms table. 
select * from rooms
order by roomid desc limit 2;


-- Question - 186] List all rooms where capacity is greater than 2. 
select * from rooms where capacity>2;


-- Question - 187] Display the last 2 staff members from the Staff table. 
select * from staff
order by staffid desc limit 2;


-- Question - 188] Show all unique roles available in the hotel. 
select distinct role from staff;


-- Question - 189] Display the last 2 payments. 
select * from payments
order by paymentid;


-- Question - 190] The manager wants to see bookings where CustomerID IN (2,4,6,8) to track repeat guests. 
select * from bookings
where CustomerID IN (2,4,6,8);


-- Question - 191] Show all unique first names of customers for a duplicate check. 
select distinct firstname from customers;


-- Question - 192] Display all bookings where TotalAmount > 5000. 
select * from bookings
where TotalAmount > 5000;


-- Question - 193] The admin wants to delete all payments where Amount < 1000. 
delete from payments
where Amount < 1000;


-- Question - 194] Display all unique RoomIDs in descending order. 
select distinct RoomID from rooms
order by roomid desc;


-- Question - 195] List customers who made more than 5 bookings. 
select * from payments
where bookingid > 5;


-- Question - 196] Display all rooms by capacity in ascending order. 
select * from rooms
order by roomid desc;


-- Question - 197] Show each booking’s BookingID with TotalAmount using CONCAT. 
select concat(BookingID, ' ', TotalAmount) totalbookingamount from bookings;


-- Question - 198] List all staff working as Managers. 
select * from staff
where role like 'Manager';


-- Question - 199] Show customers whose FirstName length > 5 characters for a name-pattern study
select FirstName from customers
where length(FirstName)>5;


-- Question - 200] Display all unique capacities in descending order. 
select distinct capacity from rooms
order by capacity desc;


-- Question - 201] List staff members who share the same Role. (Staff self join) 
select s1.firstname, s1.lastname, s1.role from staff s1
join staff s2 on s1.role=s2.role and s1.staffid!=s2.staffid;


-- Question - 202] Show PaymentID, Customer Name, and BookingID for payments made using 'Credit Card'. 
select p.paymentid, concat(c.firstname, ' ', c.lastname) as Fullname, p.bookingid from payments p
join customers c on c.customerid=p.customerid
where p.paymentmethod =  'Credit Card';


-- Question - 203] Display the first 4 payments only. 
select * from payments limit 4;


-- Question - 204] Show each payment’s ID, Method, Amount in one line. 
select concat_ws(' | ', paymentid, paymentmethod, amount) as payment_details from payments;


-- Question - 205] Create a VIEW HighValueBookings showing all bookings with TotalAmount > 20,000.
create view HighValueBookings as 
select * from bookings where TotalAmount > 20000;


-- Question - 206] Create a trigger to automatically delete a payment when its corresponding booking is deleted. 



-- Question - 207] Create a trigger to prevent insertion of a booking where CheckOutDate < CheckInDate. 




-- Question - 208] Create a trigger to automatically update TotalAmount in Bookings when a payment is inserted in Payments. 
