create table customer(
    store_num     integer not null,
    store_name    char(20) not null,
    addr          char(20),
    addr2         char(20),
    city          char(15),
    state         char(2),
    zipcode       char(5),
    contact_name  char(30),
    phone         char(18), 
    primary key (store_num)
);

create table orders(
    order_num     integer not null,
    order_date    date not null,
    store_num     integer not null,
    fac_code      char(3),
    ship_instr    char(10),
    promo         char(1) not null,    
    primary key (order_num)
);

create table factory(
    fac_code      char(3) not null,
    fac_name      char(15) not null,
    primary key (fac_code)
);

create table stock(
    stock_num     integer not null,
    fac_code      char(3) not null,
    description   char(15) not null,
    reg_price     decimal(8,2) not null,
    promo_price   decimal(8,2),
    price_updated date,
    unit          char(4) not null,
    primary key (stock_num)
);

create table items(
    order_num     integer not null,
    stock_num     integer not null,
    quantity      smallint not null,
    price         decimal(8,2) not null,
    primary key (order_num, stock_num)
);

create table state(
    state_code char(2) not null,
    state_name char(15) not null,
    primary key (state_code)
);

