delete from items;
delete from orders;
delete from stock;
delete from factory;
delete from customer;
delete from state;

insert into customer values (101,"Bandy's Hardware","110 Main","","Chicago","IL","60068","Bob Bandy","630-221-9055");
insert into customer values (102,"The FIX-IT Shop","65W Elm Street Sqr.","","Madison","WI","65454","","630-34343434");
insert into customer values (103,"Hill's Hobby Shop","553 Central Parkway","","Eau Claire","WI","54354","Janice Hilstrom","666-4564564");
insert into customer values (104,"Illinois Hardware","123 Main Street","","Peoria","IL","63434","Ramon Aguirra","630-3434334");
insert into customer values (105,"Tools and Stuff","645W Center Street","","Dubuque","IA","54654","Lavonne Robinson","630-4533456");
insert into customer values (106,"TrueTest Hardware","6123 N. Michigan Ave","","Chicago","IL","60104","Michael Mazukelli","640-3453456");
insert into customer values (202,"Fourth Ill Hardware","6123 N. Michigan Ave","","Chicago","IL","60104","Michael Mazukelli","640-3453456");
insert into customer values (203,"2nd Hobby Shop","553 Central Parkway","","Eau Claire","WI","54354","Janice Hilstrom","666-4564564");
insert into customer values (204,"2nd Hardware","123 Main Street","","Peoria","IL","63434","Ramon Aguirra","630-3434334");
insert into customer values (205,"2nd Stuff","645W Center Street","","Dubuque","IA","54654","Lavonne Robinson","630-4533456");
insert into customer values (206,"2ndTest Hardware","6123 N. Michigan Ave","","Chicago","IL","60104","Michael Mazukelli","640-3453456");
insert into customer values (302,"Third FIX-IT Shop","65W Elm Street Sqr.","","Madison","WI","65454","","630-34343434");
insert into customer values (303,"Third Hobby Shop","553 Central Parkway","","Eau Claire","WI","54354","Janice Hilstrom","666-4564564");
insert into customer values (304,"Third IL Hardware","123 Main Street","","Peoria","IL","63434","Ramon Aguirra","630-3434334");
insert into customer values (305,"Third and Stuff","645W Center Street","","Dubuque","IA","54654","Lavonne Robinson","630-4533456");
insert into customer values (306,"Third Hardware","6123 N. Michigan Ave","","Chicago","IL","60104","Michael Mazukelli","640-3453456");

insert into orders values (1,"02/02/2008",101,"ASC","FEDEX","N");
insert into orders values (2,"03/03/2008",102,"ASC","FEDEX","Y");
insert into orders values (3,"03/03/2008",103,"PHL","FEDEX","Y");
insert into orders values (4,"03/03/2008",104,"ASC","FEDEX","Y");
insert into orders values (5,"04/04/2008",101,"ASC","FEDEX","Y");
insert into orders values (6,"04/04/2008",105,"ASC","FEDEX","Y");
insert into orders values (7,"05/05/2008",104,"PHL","FEDEX","Y");
insert into orders values (8,"05/05/2008",101,"ASC","FEDEX","Y");
insert into orders values (9,"05/05/2008",101,"ASC","FEDEX","Y");
insert into orders values (10,"06/06/2008",106,"PHL","FEDEX","Y");

insert into items values (1,456,10,5.55);
insert into items values (1,310,5,12.85);
insert into items values (1,744,60,250.95);
insert into items values (2,456,15,5.55);
insert into items values (2,310,2,12.85);
insert into items values (3,323,2,0.95);
insert into items values (4,744,60,250.95);
insert into items values (4,456,15,5.55);
insert into items values (5,456,12,5.55);
insert into items values (5,310,15,12.85);
insert into items values (5,744,6,250.95);
insert into items values (6,456,15,5.55);
insert into items values (6,310,2,12.85);
insert into items values (7,323,10,0.95);
insert into items values (8,456,10,5.55);
insert into items values (8,310,15,12.85);
insert into items values (9,744,20,250.95);
insert into items values (10,323,200,0.95);

insert into stock values (456,"ASC","lightbulbs",5.55,5.0,"01/01/2008","ctn");
insert into stock values (310,"ASC","sink stoppers",12.85,11.57,"02/02/2008","grss");
insert into stock values (323,"PHL","bolts",0.95,0.86,"01/01/2008","8/bx");
insert into stock values (744,"ASC","faucets",250.95,225.86,"11/11/2007","6/bx");
insert into stock values (745,"ASC","sink",300.95,275.86,"11/11/2007","each");
insert into stock values (324,"PHL","washers",0.95,0.86,"01/01/2008","8/bx");
insert into stock values (602,"PHL","silicon press",6.95,5.86,"10/10/2007","each");
insert into stock values (330,"PHL","gloves",10.95,9.85,"09/09/2007","9/bx");
insert into stock values (326,"PHL","bolt cutters",22.95,20.72,"01/01/2008","each");
insert into stock values (325,"PHL","bolt nuts",0.95,0.86,"01/01/2008","8/bx");
insert into stock values (331,"PHL","clipboard",11.95,10.95,"08/08/2007","14ct");
insert into stock values (600,"PHL","asst drill bits",42.95,38.85,"12/12/2007","48ct");
insert into stock values (746,"ASC","grease trap",250.00,225.00,"01/01/2008","each");



insert into factory values ("ASC","Assoc. Std. Co.");
insert into factory values ("PHL","Phelps Lighting");

insert into state values ("IL","Illinois");
insert into state values ("IA","Iowa");
insert into state values ("WI","Wisconsin");


