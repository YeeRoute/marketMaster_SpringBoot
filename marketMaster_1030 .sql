--�Ыت��
use ispan;

-- �Ыذӫ~��
CREATE TABLE products (
    product_id VARCHAR(30) NOT NULL PRIMARY KEY, -- �ӫ~�s���A�s���}�Y��P
    product_category VARCHAR(30) NOT NULL, -- �ӫ~���O�W��
    product_name NVARCHAR(30) NOT NULL, -- �ӫ~�W��
    product_price INT NOT NULL, -- �ӫ~���
    product_safeinventory INT NOT NULL, -- �w���w�s�q
    Number_of_shelve INT NOT NULL, -- �W�[�ƶq
    Number_of_inventory INT NOT NULL, -- �w�s�ƶq
    Number_of_sale INT NOT NULL, -- �P��ƶq
    Number_of_exchange INT NOT NULL, -- �I���ƶq
    Number_of_destruction INT NOT NULL, -- �P���ƶq
    Number_of_remove INT NOT NULL, -- �U�[�ƶq
	product_available BIT NOT NULL, -- �O�_ 1 �ӫ~�b�c�⤤ 0�ӫ~�w�U�[
	is_perishable BIT NOT NULL, --�O�_ �����A���~ 0��ܫD���A���~ 1��ܥ��A���~
	product_photo VARBINARY(MAX) -- �ӫ~�Ϥ�
);

--�ЫؽL�I��
CREATE TABLE inventory_check (
    inventory_check_id VARCHAR(30) NOT NULL PRIMARY KEY, -- �L�I�s��
	employee_id VARCHAR(30) NOT NULL, --�t�d���uID�A�~��A���V
	inventory_check_date DATE NOT NULL, --�L�I��� 
	verify_status BIT NOT NULL, --�f�֪��A 1 �w�f�� 0 ���f��
	verify_employee_id VARCHAR(30) --�f�֤H
 );

--�ЫؽL�I����
CREATE TABLE inventory_check_details (
	detail_id VARCHAR(30) NOT NULL PRIMARY KEY, --�L�I���ӽs��
    inventory_check_id VARCHAR(30) NOT NULL, -- �L�I�s�� �~��
	product_id VARCHAR(30) NOT NULL, --�ӫ~�s�� �~��
	current_inventory INT  NOT NULL, --��e�w�s�ƶq
	actual_inventory INT NOT NULL, --�L�I���ڼƶq
	differential_inventory INT  NOT NULL, --�w�s�ƶq�t��
    remark NVARCHAR(255) --�Ƶ� �ӫ~���ʭ�]
);

-- �Ыح��u��
CREATE TABLE employee (
    employee_id VARCHAR(30) NOT NULL PRIMARY KEY, -- ���u�s���}�Y��E
    employee_name NVARCHAR(30) NOT NULL, -- ���u�m�W
    employee_tel VARCHAR(30) NOT NULL, -- ���u���
    employee_idcard VARCHAR(30) NOT NULL, -- ���u�����Ҹ��X
    employee_email VARCHAR(30) NOT NULL, -- ���uemail
    password VARCHAR(60) NOT NULL, -- ���u�K�X
    position_id VARCHAR(30) NOT NULL, -- ¾��s��
    hiredate DATE NOT NULL, -- �J¾��
    resigndate DATE, -- ��¾��
    is_first_login BIT NOT NULL DEFAULT 1, -- �P�_���u�n�J�A��ܩ|���ק�K�X
    image_path NVARCHAR(255) -- �Ϥ����|���
);

-- �Ыخ����q��
CREATE TABLE notification (
    id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id VARCHAR(30) NOT NULL,
    message NVARCHAR(500) NOT NULL,
	notification_type VARCHAR(30),
    is_read BIT NOT NULL,
	created_at DATETIME2 NOT NULL,
);

-- �Ыز�ѰT��
CREATE TABLE chat_messages (
    id INT IDENTITY(1,1) PRIMARY KEY,
    from_user VARCHAR(30) NOT NULL,
    to_user VARCHAR(30) NOT NULL,
    content NVARCHAR(MAX) NOT NULL,
    timestamp DATETIME2 NOT NULL
);

-- �إߨ����Ӫ�A�s�x�����Ӫ��򥻫H��
CREATE TABLE suppliers (
	supplier_id VARCHAR(30) NOT NULL,       -- ������ID�A�D��
	supplier_name NVARCHAR(50) NOT NULL,     -- �����ӦW��
	address NVARCHAR(50) NOT NULL,           -- �����Ӧa�}
	tax_number VARCHAR(30) NOT NULL,        -- �����ӵ|��
	contact_person NVARCHAR(30) NOT NULL,    -- �p���H
	phone VARCHAR(30) NOT NULL,             -- �p���q��
	email VARCHAR(30) NOT NULL,             -- �p���q�l�l��
	bank_account VARCHAR(30),               -- �Ȧ�b��
	PRIMARY KEY (supplier_id)               -- �]�w�D�䬰 supplier_id�A�ߤ@���Ѩ�����
);

-- �إߨ����Ӱӫ~��A�O�������Ӵ��Ѫ��ӫ~�Ψ����
CREATE TABLE supplier_products (
	supplier_product_id VARCHAR(30) NOT NULL, -- �����Ӱӫ~ID�A�D��
	supplier_id VARCHAR(30) NOT NULL,         -- ������ID�A�~��A���V suppliers ��
	product_id VARCHAR(30) NOT NULL,          -- �ӫ~ID�A�~��A���V products ��
	product_price INT NOT NULL,               -- �ӫ~����A�Ѩ����ӳ]�w
	status INT NOT NULL,                      -- �ӫ~���A�]0: ���i�ΡA1: �i�Ρ^
	PRIMARY KEY (supplier_product_id),        -- �]�w�D�䬰 supplier_product_id
	--FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id), -- �إ߻P suppliers ���~�����p
	--FOREIGN KEY (product_id) REFERENCES products(product_id)     -- �إ߻P products ���~�����p
);

-- �إߨ����ӱb���A�O�������Ӫ��b�᪬�p
CREATE TABLE supplier_accounts (
	account_id VARCHAR(30) NOT NULL,          -- �b��ID�A�D��
	supplier_id VARCHAR(30) NOT NULL,         -- ������ID�A�~��A���V suppliers ��
	total_amount INT NOT NULL,                -- �������`���I���B
	paid_amount INT NOT NULL,                 -- �����Ӥw�I�ڪ��B
	unpaid_amount INT NOT NULL,               -- �����ӥ��I�ڪ��B
	PRIMARY KEY (account_id),                 -- �]�w�D�䬰 account_id
	--FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) -- �إ߻P suppliers ���~�����p
);

-- �إ߶i�f��A�O���i�f���򥻫H��
CREATE TABLE restocks (
	restock_id VARCHAR(30) NOT NULL,          -- �i�fID�A�D��
	restock_total_price INT NOT NULL,         -- �i�f�`����
	restock_date DATE NOT NULL,               -- �i�f���
	employee_id VARCHAR(30),                  -- ���uID�A�~��A���V employee ��
	PRIMARY KEY (restock_id),                 -- �]�w�D�䬰 restock_id
	--FOREIGN KEY (employee_id) REFERENCES employee(employee_id) -- �إ߻P employee ���~�����p
);

-- �إ߶i�f���Ӫ�A�O���C���i�f���]�t���ӫ~�Ա��A�����[�J supplier_id ���
CREATE TABLE restock_details (
	detail_id VARCHAR(30) NOT NULL,           -- ����ID�A�D��
	restock_id VARCHAR(30) NOT NULL,          -- �i�fID�A�~��A���V restocks ��
	supplier_id VARCHAR(30) NOT NULL,         -- ������ID�A�~��A���V suppliers ��
	supplier_product_id VARCHAR(30) NOT NULL, -- �����Ӱӫ~ID�A�~��A���V supplier_products ��
	number_of_restock INT NOT NULL,           -- �i�f�ӫ~�ƶq
	price_at_restock INT NOT NULL,            -- �i�f�ɪ�����
	restock_total_price INT NOT NULL,         -- �i�f�ӫ~�`����
	production_date DATE NOT NULL,            -- �ӫ~���Ͳ����
	due_date DATE NOT NULL,                   -- �ӫ~��������
	restock_date DATE NOT NULL,               -- �ӫ~���i�f���
	PRIMARY KEY (detail_id),                  -- �]�w�D�䬰 detail_id
	--FOREIGN KEY (restock_id) REFERENCES restocks(restock_id), -- �إ߻P restocks ���~�����p
	--FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id), -- �إ߻P suppliers ���~�����p
	--FOREIGN KEY (supplier_product_id) REFERENCES supplier_products(supplier_product_id) -- �إ߻P supplier_products ���~�����p
);
   
-- �إߥI�ڪ�A�O����I��������T
CREATE TABLE payments (
	payment_id VARCHAR(30) NOT NULL,          -- �I��ID�A�D��
	account_id VARCHAR(30) NOT NULL,          -- �b��ID�A�~��A���V supplier_accounts ��
	payment_date DATE NOT NULL,               -- �I�ڤ��
	payment_method NVARCHAR(30) NOT NULL,      -- ��I�覡
	total_amount INT NOT NULL,                -- �I���`�B
	payment_status NVARCHAR(30) NOT NULL,      -- ��I���A
	PRIMARY KEY (payment_id),                 -- �]�w�D�䬰 payment_id
	--FOREIGN KEY (account_id) REFERENCES supplier_accounts(account_id) -- �إ߻P supplier_accounts ���~�����p
);

-- �إߥI�ڰO����A�O���C���I�ڪ��Ӹ`
CREATE TABLE payment_records (
	record_id VARCHAR(30) NOT NULL,           -- �O��ID�A�D��
	payment_id VARCHAR(30) NOT NULL,          -- �I��ID�A�~��A���V payments ��
	detail_id VARCHAR(30) NOT NULL,          -- �i�fID�A�~��A���V restocks ��
	payment_amount INT NOT NULL,              -- �I�ڪ��B
	PRIMARY KEY (record_id),                  -- �]�w�D�䬰 record_id
	--FOREIGN KEY (payment_id) REFERENCES payments(payment_id),   -- �إ߻P payments ���~�����p
	--FOREIGN KEY (detail_id) REFERENCES restock_details(detail_id)    -- �إ߻P restocks ���~�����p
);

-- �Ыذh�f���Ӫ�
CREATE TABLE return_details (
    return_id VARCHAR(30) NOT NULL, -- �h�f�s��
    original_checkout_id VARCHAR(30) NOT NULL, -- ��l���b�s��
    product_id VARCHAR(30) NOT NULL, -- �ӫ~�s��
    reason_for_return NVARCHAR(30) NOT NULL, -- �h�f��]
    number_of_return INT NOT NULL, -- �ӫ~�ƶq
	product_price INT NOT NULL, -- �ӫ~����
    return_price INT NOT NULL, -- �p�p
	return_status NVARCHAR(30) NOT NULL, -- �h�f�ӫ~���A
    return_photo NVARCHAR(255), -- �h�f�ӫ~�Ӥ�
	CONSTRAINT PK_return_details PRIMARY KEY (return_id, original_checkout_id, product_id),
	CONSTRAINT CHK_return_status 
        CHECK (return_status IN (N'�U�Ȧ]��', N'�ӫ~�~�[�l��', N'�ӫ~�~�貧�`'))
);

-- �Ыذh�f��
CREATE TABLE return_products (
    return_id VARCHAR(30) NOT NULL PRIMARY KEY, -- �h�f�s���A�s���}�Y��T
	original_checkout_id VARCHAR(30) NOT NULL, -- ��l���b�s��
	original_invoice_number VARCHAR(30) NOT NULL, -- ��l�o�����X�A�s����IN�}�Y�A�᭱��8���X 
    employee_id VARCHAR(30) NOT NULL, -- ���u�s��
    return_total_price INT NOT NULL, -- �h�f���B
    return_date DATE NOT NULL, -- �h�f���
);

-- �Ыص��b���Ӫ�
CREATE TABLE checkout_details (
    checkout_id VARCHAR(30) NOT NULL, -- ���b�s��
    product_id VARCHAR(30) NOT NULL, -- �ӫ~�s��
    number_of_checkout INT NOT NULL, -- �ӫ~�ƶq
    product_price INT NOT NULL, -- �ӫ~����
    checkout_price INT NOT NULL, -- �p�p
	CONSTRAINT checkout_details_checkout_id_product_id_PK PRIMARY KEY(checkout_id,product_id)
);

-- �Ыص��b��
CREATE TABLE checkout (
    checkout_id VARCHAR(30) NOT NULL PRIMARY KEY, -- ���b�s���A�s���}�Y��C
	invoice_number VARCHAR(30) NOT NULL, -- �o�����X�A�s����IN�}�Y�A�᭱��8���X
	customer_tel VARCHAR(30), -- �|�����
    employee_id VARCHAR(30) NOT NULL, -- ���u�s��
    checkout_total_price INT NOT NULL, -- ���b���B
    checkout_date DATE NOT NULL, -- ���b��
	bonus_points INT , -- ���Q�I��
    points_due_date DATE, -- ���Q�I�ƨ����
	checkout_status NVARCHAR(10) NOT NULL, -- ���b�檬�A(���`,�w�h�f)
	related_return_id VARCHAR(30), -- �����h�f�s��
	CONSTRAINT CHK_checkout_status CHECK (checkout_status IN (N'���`', N'�w�h�f'))
);

-- �Ы�¾�Ū�
CREATE TABLE ranklevel (
    position_id VARCHAR(30) NOT NULL PRIMARY KEY, -- ¾��s���}�YM
	position_name NVARCHAR(30) NOT NULL,	--¾��W��
    limits_of_authority INT NOT NULL, -- �v��
    salary_level VARCHAR(30) NOT NULL -- �~��ż�
);

-- �ЫرƯZ��
CREATE TABLE schedule (
                          schedule_id INT AUTO_INCREMENT PRIMARY KEY,        -- �ƯZID
                          employee_id VARCHAR(30) NOT NULL,                  -- ���u�s��
                          schedule_date DATE NOT NULL,                       -- �ƯZ���
                          start_time TIME NOT NULL,                          -- �Z���}�l�ɶ�
                          end_time TIME NOT NULL,                            -- �Z�������ɶ�
                          schedule_hour INT,                                 -- �ɼ�
                          schedule_active TINYINT(1) NOT NULL DEFAULT 1      -- �ƯZ�N�@�]1 ��ܦ��ġA0 ��ܵL�ġ^
);

-- �Ыؽа���
CREATE TABLE ask_for_leave (
    leave_id VARCHAR(30) NOT NULL PRIMARY KEY,  -- �а��s��
    employee_id VARCHAR(30) NOT NULL,          -- ���u�s��
    start_time DATETIME2 NOT NULL,             -- �а��}�l�ɶ�
    end_time DATETIME2 NOT NULL,               -- �а������ɶ�
    reason_leave NVARCHAR(255),                -- �а���]
    proof_image VARBINARY(MAX),                -- �а��ҩ�
    approved_status NVARCHAR(30) NOT NULL,     -- ��㪬�A
    category_id INT NOT NULL,                  -- �а����OID
	leave_hours INT NOT NULL,					--�а��ɼ�
	rejection_reason NVARCHAR(255)	           -- ��^��]
);

-- �Ы� �а����O��
CREATE TABLE leave_category (
    category_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,  -- id
    leave_type NVARCHAR(50) NOT NULL,                   -- �а����O
	max_hours INT NULL				                     --�̤j�ɼ� 
);

-- �Ыؽа�������
CREATE TABLE leave_record (
    record_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,  -- id
    employee_id VARCHAR(30) NOT NULL,                  -- ���u�s��
    category_id INT NOT NULL,                          -- �а����OID
    expiration_date Date NOT NULL,                       -- �����
    actual_hours INT NULL DEFAULT 0 ,                  -- ��ڮɼơA�w�]�� 0
	limit_hours INT										-- �B�׮ɼ�
);

-- �Ыط|����
CREATE TABLE customer (
    customer_tel VARCHAR(30) NOT NULL PRIMARY KEY, -- �|�����
    customer_name VARCHAR(30) NOT NULL, -- �|���m�W
    customer_email VARCHAR(30) NOT NULL, -- email
    date_of_registration DATE NOT NULL, -- ���U���
    total_points INT  NOT NULL -- �ֿn���Q�I�� --Create�ɥ��]�w��0
);

-- �Ыج��Q�I���ӫ~��u
CREATE TABLE bonus_exchange (
    exchange_id VARCHAR(30) NOT NULL PRIMARY KEY, -- �I���s���A�s���}�Y��H
    product_id VARCHAR(30) NOT NULL, -- �ӫ~�s��REFERENCES products(product_id)
	customer_tel VARCHAR(30) NOT NULL, -- �|�����REFERENCES customer(customer_tel)
    use_points INT NOT NULL, -- �ϥά��Q�I��
    number_of_exchange INT NOT NULL, -- �I���ƶq
    exchange_date DATE NOT NULL, -- �I�����
);

-- �Ыج��Q������
CREATE TABLE points_history (
    points_history_id INT IDENTITY(1,1) PRIMARY KEY, -- ���Q�s��
    customer_tel VARCHAR(30) NOT NULL, -- �|�����REFERENCES customer(customer_tel)
    checkout_id VARCHAR(30), -- ���b�s��REFERENCES checkout(checkout_id)
    exchange_id VARCHAR(30), -- �I���s��REFERENCES bonus_exchange(exchange_id)
    points_change INT NOT NULL, -- ���Q�I���ܰʶq
    transaction_date DATE NOT NULL, -- ���Q�O�����
    transaction_type VARCHAR(10) NOT NULL CHECK (transaction_type IN ('earn', 'use', 'expire')) -- ���Q���A
);

--======================================================================
--�s�W���

-- ���J�ӫ~���
INSERT INTO products ( product_id, product_category, product_name, product_price, product_safeinventory, Number_of_shelve, Number_of_inventory, Number_of_sale, Number_of_exchange, Number_of_destruction, Number_of_remove, product_available, is_perishable
) VALUES 
('PMS001', '�׫~���A', '�ަ�', 180, 30, 10, 25, 12, 2, 3, 0, 1, 1), 
('PMS002', '�׫~���A', '����', 320, 25, 12, 37, 15, 1, 2, 0, 1, 1), 
('PMS003', '�׫~���A', '����', 150, 35, 15, 30, 18, 0, 2, 0, 1, 1), 
('PMS004', '�׫~���A', '����', 160, 28, 10, 50, 16, 1, 3, 0, 1, 1),
('PMS005', '�׫~���A', '��', 200, 32, 16, 25, 14, 2, 4, 0, 1, 1), 
('PVF001', '������G', '�ɦ�', 35, 40, 15, 50, 20, 3, 5, 0, 1, 1),
('PVF002', '������G', '�f�X', 25, 45, 20, 50, 25, 2, 4, 0, 1, 1),
('PVF003', '������G', '�p����', 20, 40, 25, 65, 22, 1, 3, 0, 1, 1),
('PVF004', '������G', '�Ťߵ�', 30, 42, 18, 45, 24, 2, 5, 0, 1, 1),
('PVF005', '������G', '���R��', 45, 38, 22, 58, 18, 1, 4, 0, 1, 1),
('PSN001', '�s���I��', '�Ĩ�', 25, 80, 40, 100, 30, 2, 1, 0, 1, 0),
('PSN002', '�s���I��', '������', 25, 75, 25, 75, 25, 1, 1, 0, 1, 0),
('PSN003', '�s���I��', '�i�֪G', 20, 80, 30, 70, 28, 2, 1, 0, 1, 0),
('PSN004', '�s���I��', 'Ĭ���氮', 35, 78, 38, 92, 26, 1, 1, 0, 1, 0),
('PSN005', '�s���I��', '�h�O�h��', 30, 82, 35, 75, 32, 2, 1, 0, 1, 0),
('PRN001', '�̶��ѱ�', '���W��', 150, 60, 20, 52, 15, 1, 0, 0, 1, 0),
('PRN002', '�̶��ѱ�', '�q�j�Q��', 85, 70, 25, 80, 20, 0, 1, 0, 1, 0),
('PRN003', '�̶��ѱ�', '�V��', 45, 65, 30, 85, 18, 1, 0, 0, 1, 0),
('PRN004', '�̶��ѱ�', '�⥴��', 95, 68, 22, 72, 22, 1, 1, 0, 1, 0),
('PRN005', '�̶��ѱ�', '���q��', 45, 62, 28, 82, 16, 0, 0, 0, 1, 0),
('PDR001', '���~', '�i��', 25, 90, 35, 92, 35, 1, 1, 0, 1, 0),
('PDR002', '���~', '����', 25, 85, 30, 95, 30, 1, 1, 0, 1, 0),
('PDR003', '���~', '�B�ԩ@��', 35, 95, 35, 100, 40, 2, 1, 0, 1, 0),
('PDR004', '���~', '���', 20, 100, 40, 70, 45, 1, 1, 0, 1, 0),
('PDR005', '���~', '�ªQFIN�ɵ�����', 25, 92, 32, 100, 38, 2, 1, 0, 1, 0);

-- ���J�L�I���
INSERT INTO inventory_check (inventory_check_id, employee_id, inventory_check_date,verify_status)
VALUES 
('IC001', 'E001', '2024-10-01',1),
('IC002', 'E002', '2024-10-02',1),
('IC003', 'E003', '2024-10-03',1);

-- ���J��L�I����
INSERT INTO inventory_check_details (detail_id, inventory_check_id, product_id, current_inventory, actual_inventory, differential_inventory, remark)
VALUES 
('ICD00000001', 'IC001', 'PMS001', 50, 48, -2, '�ƶq��֡A�ӫ~�l�a'),
('ICD00000002', 'IC001', 'PMS002', 30, 30, 0, '�L�t��'),
('ICD00000003', 'IC002', 'PMS003', 100, 98, -2, '�ӫ~�}�l'),
('ICD00000004', 'IC002', 'PMS004', 25, 27, 2, '�վ�O�����~'),
('ICD00000005', 'IC003', 'PMS005', 60, 60, 0, '�L�t��');


-- ���J�����Ӹ��
INSERT INTO suppliers (supplier_id, supplier_name, address, tax_number, contact_person, phone, email, bank_account) VALUES
	('S001', '�p��', '812 �������p��Ϯc����14��', '07569627', '��v��', '0912345678', 'tomlin@lianhwa.com.tw', '808-0939979294191'),
	('S002', '���s', '950 �O�F���O�F���~����11��', '10508879', '�����|', '0915001903', 'fascinated@yahoo.com', '777-0939979294191'),
	('S003', '���u', '732 �O�n���ժe�Ϥ��X�Y11��', '22346371', '����X', '0920049630', 'ourtordered@outlook.com', '555-0939979294191'),
	('S004', '����', '412 �O�����j���ϥҳ��T��35��', '90458083', '�����', '0924410258', 'graying@gmail.com', '333-0939979294191'),
	('S005', '�n��', '640 ���L���椻���βy�Q�K��13��', '70974461', '������', '0938327361', 'softspoken@gmail.com', '111-0939979294191');

-- ���J�����Ӱӫ~���
-- ���]�w�� products ��M�����ӫ~���
INSERT INTO supplier_products (supplier_product_id, supplier_id, product_id, product_price, status) VALUES
	('SP001', 'S001', 'PDR001', 20, 1),
	('SP002', 'S002', 'PDR002', 25, 1),
	('SP003', 'S003', 'PDR003', 30, 1),
	('SP004', 'S004', 'PDR004', 35, 1),
	('SP005', 'S005', 'PDR005', 40, 1),
	('SP006', 'S001', 'PMS001', 100, 1),
	('SP007', 'S002', 'PMS002', 150, 1),
	('SP008', 'S003', 'PMS003', 200, 1),
	('SP009', 'S004', 'PMS004', 120, 1),
	('SP010', 'S005', 'PMS005', 130, 1),
	('SP011', 'S001', 'PRN001', 50, 1),
	('SP012', 'S002', 'PRN002', 60, 1),
	('SP013', 'S003', 'PRN003', 70, 1),
	('SP014', 'S004', 'PRN004', 80, 1),
	('SP015', 'S005', 'PRN005', 90, 1),
	('SP016', 'S001', 'PSN001', 15, 1),
	('SP017', 'S002', 'PSN002', 18, 1),
	('SP018', 'S003', 'PSN003', 20, 1),
	('SP019', 'S004', 'PSN004', 22, 1),
	('SP020', 'S005', 'PSN005', 25, 1),
	('SP021', 'S001', 'PVF001', 10, 1),
	('SP022', 'S002', 'PVF002', 12, 1),
	('SP023', 'S003', 'PVF003', 15, 1),
	('SP024', 'S004', 'PVF004', 18, 1),
	('SP025', 'S005', 'PVF005', 20, 1),
	('SP026', 'S002', 'PDR001', 30, 1),
	('SP027', 'S003', 'PDR001', 40, 0),
	('SP028', 'S004', 'PDR001', 50, 0),
	('SP029', 'S005', 'PDR001', 60, 1);

-- ���J�����ӱb����
INSERT INTO supplier_accounts (account_id, supplier_id, total_amount, paid_amount, unpaid_amount) VALUES
	('ACC001', 'S001', 2000, 2000, 0),
	('ACC002', 'S002', 3000, 2000, 1000),
	('ACC003', 'S003', 2400, 2400, 0),
	('ACC004', 'S004', 2450, 2450, 0),
	('ACC005', 'S005', 3600, 3600, 0);

-- ���J�i�f���
INSERT INTO restocks (restock_id, restock_total_price, restock_date, employee_id) VALUES
	('20241002001', 5000, '2024-10-02', 'E001'),
	('20241002002', 1250, '2024-10-02', 'E001'),
	('20241002003', 2400, '2024-10-02', 'E001'),
	('20241002004', 2450, '2024-10-02', 'E001'),
	('20241002005', 3600, '2024-10-02', 'E001');

-- ���J�i�f���Ӹ�ơA�����]�t supplier_id
INSERT INTO restock_details (detail_id, restock_id, supplier_id, supplier_product_id, number_of_restock, price_at_restock, restock_total_price, production_date, due_date, restock_date) VALUES
	('RD001', '20241002001', 'S001', 'SP001', 100,20, 2000, '2024-09-01', '2025-09-01', '2024-10-02'),
	('RD002', '20241002001', 'S002', 'SP012', 50,60, 3000, '2024-09-01', '2025-09-01', '2024-10-02'),
	('RD003', '20241002002', 'S002', 'SP012', 50,25, 1250, '2024-09-01', '2025-09-01', '2024-10-02'),
	('RD004', '20241002003', 'S003', 'SP003', 80, 30,2400, '2024-07-20', '2025-07-20', '2024-10-02'),
	('RD005', '20241002004', 'S004', 'SP004', 70,35, 2450, '2024-06-10', '2025-06-10', '2024-10-02'),
	('RD006', '20241002005', 'S005', 'SP005', 90,40, 3600, '2024-05-25', '2025-05-25', '2024-10-02');

-- ���J�I�ڸ��
INSERT INTO payments (payment_id, account_id, payment_date, payment_method, total_amount, payment_status) VALUES
    ('PMT006', 'ACC001', '2024-10-10', '�Ȧ���b', 12250, '�w��I');

-- ���J�I�ڰO����ơA���� detail_id
INSERT INTO payment_records (record_id, payment_id, detail_id, payment_amount) VALUES
	('REC001', 'PMT006', 'RD001', 2000), -- S001: RD001
	('REC002', 'PMT006', 'RD002', 2000), -- S002: RD002 ������I
	('REC003', 'PMT006', 'RD003', 1250), -- S002: RD003
	('REC004', 'PMT006', 'RD004', 2400), -- S003: RD004
	('REC005', 'PMT006', 'RD005', 2450), -- S004: RD005
	('REC006', 'PMT006', 'RD006', 1200); -- S005: RD006 ������I

-- �s�W¾�ũM���u
INSERT INTO ranklevel (position_id, position_name, limits_of_authority, salary_level)
VALUES
	('M01', '�g�z', 3, 'SSS'),
	('M02', '�D��', 2, 'SS'),
	('M03', '���u', 1, 'S');

INSERT INTO employee (employee_id, employee_name, employee_tel, employee_idcard, employee_email, password, position_id, hiredate, resigndate, is_first_login, image_path)
VALUES
	('E001', '����', '0900123123', 'A123456789', 'aaa0001@gmail.com', '0000', 'M01', '2024-06-13', NULL,1, NULL),
	('E002', '����', '0900456456', 'B123456789', 'aaa0002@gmail.com', '0000', 'M02', '2024-06-13', NULL,1, NULL),
	('E003', '��޳', '0900789789', 'C123456789', 'aaa0003@gmail.com', '0000', 'M03', '2024-06-13', NULL,1, NULL),
	('E004', '����', '0900321321', 'D123456789', 'aaa0004@gmail.com', '0000', 'M03', '2024-06-13', NULL,1, NULL),
	('E005', '����', '0900654654', 'E123456789', 'aaa0005@gmail.com', '0000', 'M03', '2024-06-13', NULL,1, NULL),
	('E006', '����', '0900987987', 'F123456789', 'ricekevin22@gmail.com', '0000', 'M02', '2024-06-13', NULL,1, NULL),
	('E007', '����', '0933654654', 'G123456789', 'aaa0006@gmail.com', '0000', 'M03', '2024-06-20', '2024-08-31',0, NULL),
	('E008', '����', '0974147414', 'H123456789', 'aaa0007@gmail.com', '0000', 'M02', '2024-06-20', '2024-10-15',0, NULL),
	('E009', '����', '0955885885', 'J123456789', 'aaa0008@gmail.com', '0000', 'M03', '2024-06-21', '2024-10-20',0, NULL),
	('E010', '����', '0911236236', 'K123456789', 'aaa0009@gmail.com', '0000', 'M03', '2024-07-12', NULL,1, NULL),
	('E011', '����', '0914236556', 'L123456789', 'aaa0010@gmail.com', '0000', 'M03', '2024-09-18', NULL,1, NULL);

-- �s�W���
INSERT INTO chat_messages (from_user, to_user, content, timestamp)
VALUES 
-- ����(E001)�o�e����L�H���T��
('E001', 'E002', '�������w�A���ѤU�Ȩ��I���M�׷|ĳ�O�o�n�ǳƲĤ@�u���P������', '2024-06-15 08:30:00'),
('E001', 'E003', '޳޳�A�i�H���ڬݤ@�U�t�κ��@���ɵ{�w�ƶܡH�Ȥ�b�ʤF', '2024-07-05 09:15:00'),
('E001', 'E006', '�����A�U�g�������w��|ĳ����ƷǳƱo�p��F�H', '2024-08-12 10:20:00'),
('E001', 'E010', '�����A�s�Ӫ���ߥͧڥ��w�Ʀb�A����ǲߥi�H�ܡH', '2024-09-05 11:30:00'),
('E001', 'E002', '�O�o�U�Z�e��|ĳ�����ǵ��ڹL�ؤ@�U�A����', '2024-10-15 16:45:00'),

-- ����(E002)�o�e����L�H���T��
('E002', 'E001', '�n�������A�ڤw�g��z�n����F�A�����|���ǵ��A�L��', '2024-06-15 08:35:00'),
('E002', 'E006', '�����A�޳N�����䪺�s�t�δ��յ��G�X�ӤF�ܡH', '2024-07-18 13:20:00'),
('E002', 'E003', '޳޳�A�·����ڬݤ@�U���A���t�������D�A�Ȥ�����t�Φ��I�C', '2024-08-25 14:15:00'),
('E002', 'E010', '�U�g�G���Ш|�V�m�A�n�Ӥ��ɷ~�ȶ}�o�g���a�H²���ǳƦn�F��', '2024-09-18 15:30:00'),
('E002', 'E001', '�����A�|ĳ�����w�g�o��A�H�c�F�A�йL��', '2024-10-15 17:30:00'),

-- ��޳(E003)�o�e����L�H���T��
('E003', 'E001', '�n���D�ޡA�ڥ��b�B�z�t�κ��@���Ʊ��A�w�p�U�ȴN�൹�A�ɵ{��', '2024-06-20 09:20:00'),
('E003', 'E002', '�����A�ڭ��ˬd�L�F�A�O��Ʈw�ݭn�u�ơA�ڤw�g�b�B�z�F', '2024-07-28 14:20:00'),
('E003', 'E006', '�����A�s�\�઺�������ҧڤw�g�[�]�n�F�A�A�n���禬�ܡH', '2024-08-15 11:45:00'),
('E003', 'E010', '�����A���ڬݤ@�U�o�ӫȤ᪺�ݨD�W��O���O���I���D�H', '2024-09-22 13:50:00'),
('E003', 'E001', '�D�ޡA���@�ɵ{��w�g��b�@�θ�Ƨ��F�A�·ЧA�L��', '2024-10-18 15:00:00'),

-- ����(E006)�o�e����L�H���T��
('E006', 'E001', '�D�ޡA�����w����i�w�g������Z�A�ڵ����ǵ��A', '2024-06-25 10:25:00'),
('E006', 'E002', '�����A�t�δ����٦b�i�椤�A�w�p���ѤW�ȯ�X���G', '2024-08-02 13:25:00'),
('E006', 'E003', '����A�ڤU�ȤT�I�L�h�ݴ�������', '2024-09-10 11:50:00'),
('E006', 'E010', '�p���Ať���A���F�@�Ӥj�פl�H�ݭn�䴩�ܡH', '2024-09-28 14:30:00'),
('E006', 'E001', '�D�ޡA�w����i�w�g�o��A�H�c�F�A�Ьd��', '2024-10-20 16:15:00'),

-- ����(E010)�o�e����L�H���T��
('E010', 'E001', '�n���D�ޡA�ګַܼN�a�s�H�A�Цw�ƥL�L�ӧa', '2024-07-15 11:35:00'),
('E010', 'E002', '�O���A²���w�g�ǳƦn�F�A�D�n�|���ɳ̪�X�Ӧ��\�ר�', '2024-08-20 15:35:00'),
('E010', 'E003', '���´����A�ڬݹL�W��ѤF�A�T�꦳�X���I�ݭn��M�A�ڦA�M�Ȥ�T�{', '2024-09-15 14:00:00'),
('E010', 'E006', '�������ߡA�ثe�٥i�H���I�A�p�G�ݭn�䴩�ڦA�i�D�A', '2024-10-01 14:35:00'),
('E010', 'E001', '�D�ޡA�s�H���ǲ߭p���ڤw�g���n��Z�A�����ǵ��A�Ѧ�', '2024-10-22 16:00:00');

-- �s�W�|��
INSERT INTO customer (customer_tel, customer_name, customer_email, date_of_registration, total_points)
VALUES
('0912345678', '���j��', 'dawen.chen@email.com', '2024-06-15', 8),
('0923456789', '�L�p��', 'xiaomei.lin@email.com', '2024-06-18', 12),
('0934567890', '���ذ�', 'jianguo.wang@email.com', '2024-06-21', 5),
('0945678901', '�i����', 'meiling.zhang@email.com', '2024-06-24', 15),
('0956789012', '���ө�', 'zhiming.li@email.com', '2024-06-27', 3),
('0967890123', '�d�Q��', 'shufen.wu@email.com', '2024-06-30', 7),
('0978901234', '���R��', 'lihua.huang@email.com', '2024-07-03', 11),
('0989012345', '�B�T��', 'junjie.liu@email.com', '2024-07-06', 4),
('0990123456', '�P���@', 'yating.zhou@email.com', '2024-07-09', 9),
('0901234567', '�©v��', 'zonghan.xie@email.com', '2024-07-12', 13),
('0912345679', '���εY', 'jialin.yang@email.com', '2024-07-15', 6),
('0923456788', '������', 'yawen.guo@email.com', '2024-07-18', 2),
('0934567899', '�\�ӻ�', 'zhihao.xu@email.com', '2024-07-21', 14),
('0945678900', '������', 'meizhen.zhu@email.com', '2024-07-24', 8),
('0956789013', '��ا�', 'jianzhi.pan@email.com', '2024-07-27', 11),
('0967890124', '�S���', 'wenfang.fan@email.com', '2024-07-30', 5),
('0978901235', '������', 'minghong.cai@email.com', '2024-08-02', 15),
('0989012346', '�H���X', 'yaqi.shen@email.com', '2024-08-05', 7),
('0990123457', '���Ӱ�', 'zhiwei.feng@email.com', '2024-08-08', 3),
('0901234568', '�G�f��', 'huimei.zheng@email.com', '2024-08-11', 12),
('0912345670', '�c�ئt', 'jianyu.lu@email.com', '2024-08-14', 6),
('0923456781', '��Q��', 'shuhua.tang@email.com', '2024-08-17', 9),
('0934567892', '���T��', 'junxian.ye@email.com', '2024-08-20', 4),
('0945678903', '�I����', 'yafang.shi@email.com', '2024-08-23', 13),
('0956789014', '�^�ذ�', 'jianguo.peng@email.com', '2024-08-26', 8),
('0967890125', '���R�S', 'lijuan.dong@email.com', '2024-08-29', 2),
('0978901236', '���Ӧ�', 'zhicheng.jiang@email.com', '2024-09-01', 10),
('0989012347', '�J����', 'yaling.hou@email.com', '2024-09-04', 15),
('0990123458', '���ص�', 'jianhua.han@email.com', '2024-09-07', 7),
('0901234569', '�ŲQ�f', 'shuhui.fu@email.com', '2024-09-10', 5),
('0912345671', '�����w', 'mingde.zhao@email.com', '2024-09-13', 11),
('0923456782', '������', 'yaping.tong@email.com', '2024-09-16', 3),
('0934567893', '��ӻ�', 'zhiyuan.fang@email.com', '2024-09-19', 14),
('0945678904', '�ղQ��', 'shufang.bai@email.com', '2024-09-22', 6),
('0956789015', '�۫��s', 'jianlong.shi@email.com', '2024-09-25', 9),
('0967890126', '�Ƕ��p', 'yaru.gong@email.com', '2024-09-28', 12),
('0978901237', '��ӱj', 'zhiqiang.he@email.com', '2024-10-01', 4),
('0989012348', '�����@', 'yating.tang@email.com', '2024-10-04', 8),
('0990123459', '���ئ�', 'jiancheng.ren@email.com', '2024-10-07', 15),
('0901234560', '�ŲQ��', 'shuling.wu@email.com', '2024-10-10', 7),
('0912345672', '�d���s', 'mingshan.kang@email.com', '2024-10-13', 10),
('0923456783', '�����f', 'yahui.zhang@email.com', '2024-10-16', 5),
('0934567894', '���ӻ�', 'zhihao.ma@email.com', '2024-10-18', 13),
('0945678905', '�ɲQ�s', 'shuzhen.shi@email.com', '2024-10-19', 2),
('0956789016', '�Y�ؤ�', 'jianwen.yan@email.com', '2024-10-20', 11),
('0967890127', '�̶���', 'yali.mi@email.com', '2024-10-21', 6),
('0978901238', '��ө�', 'zhiming.liang@email.com', '2024-10-22', 9),
('0989012349', '������', 'yaqing.tang@email.com', '2024-10-23', 4),
('0990123450', '���ئw', 'jianan.qiu@email.com', '2024-10-24', 14),
('0901234561', '�ŲQ��', 'shuyi.wen@email.com', '2024-10-24', 8);

-- ���J ask_for_leave �а�����
INSERT INTO ask_for_leave (leave_id, employee_id, start_time, end_time, reason_leave, proof_image, approved_status, category_id, leave_hours, rejection_reason)
VALUES
('L00001', 'E001', '2024-10-21 08:00', '2024-10-21 12:00', '�]���d���D�а�', NULL, '�w���', 2, 4, NULL),
('L00002', 'E002', '2024-10-21 12:00', '2024-10-21 16:00', '�]�a�x�ݨD�а�', NULL, '�ݼf��', 3, 4, NULL),
('L00003', 'E003', '2024-10-22 08:00', '2024-10-22 12:00', '�ѥ[�B§�а�', NULL, '�w�hñ', 4, 4, '���ҩ�'),
('L00004', 'E004', '2024-10-22 12:00', '2024-10-22 16:00', '�]�ӤH�ưȽа�', NULL, '�w���', 1, 4, NULL),
('L00005', 'E005', '2024-10-23 08:00', '2024-10-23 12:00', '�]�������f�а�', NULL, '�w���', 2, 4, NULL),
('L00006', 'E006', '2024-10-23 12:00', '2024-10-23 16:00', '�]�ͯf�а�', NULL, '�ݼf��', 2, 4, NULL),
('L00007', 'E010', '2024-10-24 08:00', '2024-10-24 12:00', '�]�a�ƽа�', NULL, '�w���', 1, 4, NULL),
('L00008', 'E011', '2024-10-24 12:00', '2024-10-24 16:00', '�]�B�ͱB§�а�', NULL, '�w���', 4, 4, NULL),
('L00009', 'E012', '2024-10-25 08:00', '2024-10-25 12:00', '�]���d���D�а�', NULL, '�ݼf��', 2, 4, NULL),
('L00010', 'E013', '2024-10-25 12:00', '2024-10-25 16:00', '�]�a�̦��ƽа�', NULL, '�w���', 1, 4, NULL),
('L00011', 'E014', '2024-10-26 08:00', '2024-10-26 12:00', '�]�ͯf�а�', NULL, '�w���', 2, 4, NULL),
('L00012', 'E001', '2024-10-26 12:00', '2024-10-26 16:00', '�]�ѥ[���y�а�', NULL, '�w���', 3, 4, NULL),
('L00013', 'E002', '2024-10-27 08:00', '2024-10-27 12:00', '�]�Ȧ�а�', NULL, '�ݼf��', 5, 4, NULL),
('L00014', 'E003', '2024-10-27 12:00', '2024-10-27 16:00', '�]�a�x�ݨD�а�', NULL, '�w���', 1, 4, NULL),
('L00015', 'E004', '2024-10-28 08:00', '2024-10-28 12:00', '�]�ͯf�а�', NULL, '�w���', 2, 4, NULL),
('L00016', 'E005', '2024-10-28 12:00', '2024-10-28 16:00', '�]���d���D�а�', NULL, '�w���', 3, 4, NULL),
('L00017', 'E010', '2024-10-29 08:00', '2024-10-29 12:00', '�]�a�x�ݨD�а�', NULL, '�w���', 4, 4, NULL),
('L00018', 'E011', '2024-10-29 12:00', '2024-10-29 16:00', '�]�ˤH�B§�а�', NULL, '�w���', 5, 4, NULL),
('L00019', 'E012', '2024-10-30 08:00', '2024-10-30 12:00', '�]�f���а�', NULL, '�w���', 2, 4, NULL),
('L00020', 'E013', '2024-10-30 12:00', '2024-10-30 16:00', '�]�ưȽа�', NULL, '�w���', 1, 4, NULL),
('L00021', 'E003', '2024-10-22 08:00', '2024-10-22 12:00', '�]���d���D�а�', NULL, '�w���', 2, 4, NULL),
('L00022', 'E003', '2024-10-24 12:00', '2024-10-24 16:00', '�]�a�x�ݨD�а�', NULL, '�w���', 3, 4, NULL),
('L00023', 'E003', '2024-10-26 08:00', '2024-10-26 12:00', '�]�ѥ[�B§�а�', NULL, '�w���', 4, 4, NULL),
('L00024', 'E003', '2024-10-28 12:00', '2024-10-28 16:00', '�]�Ȧ�а�', NULL, '�ݼf��', 5, 4, NULL),
('L00025', 'E003', '2024-11-01 08:00', '2024-11-01 12:00', '�]�a�x�ݨD�а�', NULL, '�w���', 1, 4, NULL),
('L00026', 'E003', '2024-11-02 12:00', '2024-11-02 16:00', '�]�u�@�ݨD�а�', NULL, '�w���', 2, 4, NULL),
('L00027', 'E003', '2024-11-05 08:00', '2024-11-05 12:00', '�]���d���D�а�', NULL, '�w���', 3, 4, NULL),
('L00028', 'E003', '2024-11-10 12:00', '2024-11-10 16:00', '�]�a�x�ݨD�а�', NULL, '�w���', 4, 4, NULL),
('L00029', 'E003', '2024-11-15 08:00', '2024-11-15 12:00', '�]�ưȽа�', NULL, '�w���', 2, 4, NULL);

-- �s�W�а��O��
INSERT INTO leave_record (employee_id, category_id, expiration_date, actual_hours, limit_hours)
VALUES
('E001', 1, '2025-06-13', 4, 112),
('E001', 2, '2025-06-13', 8, 240),
('E002', 2, '2025-06-13', 4, 240),
('E002', 3, '2025-06-13', 8, 24),
('E003', 1, '2025-06-13', 8, 112),
('E003', 4, '2025-06-13', 20, 64),
('E004', 1, '2025-06-13', 8, 112),
('E004', 5, '2025-06-13', 4, 64),
('E005', 1, '2025-06-13', 4, 112),
('E005', 2, '2025-06-13', 8, 240),
('E010', 2, '2025-06-13', 8, 240),
('E011', 1, '2025-06-13', 8, 112),
('E012', 4, '2025-06-13', 8, 64),
('E012', 2, '2025-06-13', 4, 240),
('E013', 1, '2025-06-13', 8, 112),
('E013', 2, '2025-06-13', 4, 240),
('E014', 3, '2025-06-13', 8, 24);
--- ���J �а����O
INSERT INTO leave_category (leave_type, max_hours)
VALUES
('�ư�', 112),
('�f��', 240),           
('�S��', 240),
('�B��', 64),         
('�ల', 64),          
('���˰�', 240),        
('����', 240);          

-- ���J�ƯZ����
INSERT INTO schedule (employee_id, schedule_date, start_time, end_time, schedule_hour, schedule_active) VALUES
('E001', '2024-10-21', '08:00', '12:00', 4, 1),
('E002', '2024-10-21', '08:00', '12:00', 4, 1),
('E003', '2024-10-21', '12:00', '16:00', 4, 1),
('E004', '2024-10-21', '12:00', '16:00', 4, 1),
('E005', '2024-10-22', '08:00', '12:00', 4, 1),
('E006', '2024-10-22', '08:00', '12:00', 4, 1),
('E010', '2024-10-22', '12:00', '16:00', 4, 1),
('E001', '2024-10-22', '12:00', '16:00', 4, 1),
('E002', '2024-10-23', '08:00', '12:00', 4, 1),
('E010', '2024-10-23', '08:00', '12:00', 4, 1),
('E011', '2024-10-23', '12:00', '16:00', 4, 1),
('E001', '2024-10-23', '12:00', '16:00', 4, 1),
('E002', '2024-10-24', '08:00', '12:00', 4, 1),
('E003', '2024-10-24', '08:00', '12:00', 4, 1),
('E004', '2024-10-24', '12:00', '16:00', 4, 1),
('E005', '2024-10-24', '12:00', '16:00', 4, 1),
('E006', '2024-10-25', '08:00', '12:00', 4, 1),
('E004', '2024-10-25', '08:00', '12:00', 4, 1),
('E005', '2024-10-25', '12:00', '16:00', 4, 1),
('E006', '2024-10-25', '12:00', '16:00', 4, 1),
('E010', '2024-10-26', '08:00', '12:00', 4, 1),
('E011', '2024-10-26', '08:00', '12:00', 4, 1),
('E001', '2024-10-26', '12:00', '16:00', 4, 1),
('E002', '2024-10-26', '12:00', '16:00', 4, 1),
('E003', '2024-10-27', '08:00', '12:00', 4, 1),
('E004', '2024-10-27', '08:00', '12:00', 4, 1),
('E005', '2024-10-27', '12:00', '16:00', 4, 1),
('E006', '2024-10-27', '12:00', '16:00', 4, 1),
('E011', '2024-10-28', '08:00', '12:00', 4, 1),
('E005', '2024-10-28', '08:00', '12:00', 4, 1),
('E009', '2024-10-28', '12:00', '16:00', 4, 1),
('E010', '2024-10-28', '12:00', '16:00', 4, 1),
('E011', '2024-10-29', '08:00', '12:00', 4, 1),
('E001', '2024-10-29', '08:00', '12:00', 4, 1),
('E002', '2024-10-29', '12:00', '16:00', 4, 1),
('E003', '2024-10-29', '12:00', '16:00', 4, 1),
('E004', '2024-10-30', '08:00', '12:00', 4, 1),
('E005', '2024-10-30', '08:00', '12:00', 4, 1),
('E006', '2024-10-30', '12:00', '16:00', 4, 1),
('E003', '2024-10-30', '12:00', '16:00', 4, 1),
('E004', '2024-10-31', '08:00', '12:00', 4, 1),
('E005', '2024-10-31', '08:00', '12:00', 4, 1),
('E010', '2024-10-31', '12:00', '16:00', 4, 1),
('E011', '2024-10-31', '12:00', '16:00', 4, 1),
('E001', '2024-11-01', '08:00', '12:00', 4, 1),
('E002', '2024-11-01', '08:00', '12:00', 4, 1),
('E003', '2024-11-01', '12:00', '16:00', 4, 1),
('E004', '2024-11-01', '12:00', '16:00', 4, 1),
('E005', '2024-11-02', '08:00', '12:00', 4, 1),
('E006', '2024-11-02', '08:00', '12:00', 4, 1),
('E005', '2024-11-02', '12:00', '16:00', 4, 1),
('E003', '2024-11-02', '12:00', '16:00', 4, 1),
('E001', '2024-11-03', '08:00', '12:00', 4, 1),
('E010', '2024-11-03', '08:00', '12:00', 4, 1),
('E011', '2024-11-03', '12:00', '16:00', 4, 1),
('E001', '2024-11-03', '12:00', '16:00', 4, 1),
('E002', '2024-11-04', '08:00', '12:00', 4, 1),
('E003', '2024-11-04', '08:00', '12:00', 4, 1),
('E004', '2024-11-04', '12:00', '16:00', 4, 1),
('E005', '2024-11-04', '12:00', '16:00', 4, 1),
('E006', '2024-11-05', '08:00', '12:00', 4, 1),
('E002', '2024-11-05', '08:00', '12:00', 4, 1),
('E003', '2024-11-05', '12:00', '16:00', 4, 1),
('E005', '2024-11-05', '12:00', '16:00', 4, 1),
('E010', '2024-11-06', '08:00', '12:00', 4, 1),
('E011', '2024-11-06', '08:00', '12:00', 4, 1),
('E001', '2024-11-06', '12:00', '16:00', 4, 1),
('E002', '2024-11-06', '12:00', '16:00', 4, 1),
('E003', '2024-11-07', '08:00', '12:00', 4, 1),
('E004', '2024-11-07', '08:00', '12:00', 4, 1),
('E005', '2024-11-07', '12:00', '16:00', 4, 1),
('E006', '2024-11-07', '12:00', '16:00', 4, 1),
('E004', '2024-11-08', '08:00', '12:00', 4, 1),
('E010', '2024-11-08', '08:00', '12:00', 4, 1),
('E004', '2024-11-08', '12:00', '16:00', 4, 1),
('E010', '2024-11-08', '12:00', '16:00', 4, 1),
('E011', '2024-11-09', '08:00', '12:00', 4, 1),
('E001', '2024-11-09', '08:00', '12:00', 4, 1),
('E002', '2024-11-09', '12:00', '16:00', 4, 1),
('E003', '2024-11-09', '12:00', '16:00', 4, 1),
('E004', '2024-11-10', '08:00', '12:00', 4, 1),
('E005', '2024-11-10', '08:00', '12:00', 4, 1),
('E006', '2024-11-10', '12:00', '16:00', 4, 1),
('E011', '2024-11-10', '12:00', '16:00', 4, 1),
('E001', '2024-11-11', '08:00', '12:00', 4, 1),
('E002', '2024-11-11', '08:00', '12:00', 4, 1),
('E010', '2024-11-11', '12:00', '16:00', 4, 1),
('E011', '2024-11-11', '12:00', '16:00', 4, 1),
('E001', '2024-11-12', '08:00', '12:00', 4, 1),
('E002', '2024-11-12', '08:00', '12:00', 4, 1),
('E003', '2024-11-12', '12:00', '16:00', 4, 1),
('E004', '2024-11-12', '12:00', '16:00', 4, 1),
('E005', '2024-11-13', '08:00', '12:00', 4, 1),
('E006', '2024-11-13', '08:00', '12:00', 4, 1),
('E003', '2024-11-13', '12:00', '16:00', 4, 1),
('E004', '2024-11-13', '12:00', '16:00', 4, 1),
('E005', '2024-11-14', '08:00', '12:00', 4, 1),
('E010', '2024-11-14', '08:00', '12:00', 4, 1),
('E011', '2024-11-14', '12:00', '16:00', 4, 1),
('E001', '2024-11-14', '12:00', '16:00', 4, 1),
('E002', '2024-11-15', '08:00', '12:00', 4, 1),
('E003', '2024-11-15', '08:00', '12:00', 4, 1),
('E004', '2024-11-15', '12:00', '16:00', 4, 1),
('E005', '2024-11-15', '12:00', '16:00', 4, 1),
('E006', '2024-11-16', '08:00', '12:00', 4, 1),
('E010', '2024-11-16', '08:00', '12:00', 4, 1),
('E011', '2024-11-16', '12:00', '16:00', 4, 1),
('E009', '2024-11-16', '12:00', '16:00', 4, 1),
('E010', '2024-11-17', '08:00', '12:00', 4, 1),
('E011', '2024-11-17', '08:00', '12:00', 4, 1),
('E001', '2024-11-17', '12:00', '16:00', 4, 1),
('E002', '2024-11-17', '12:00', '16:00', 4, 1),
('E003', '2024-11-18', '08:00', '12:00', 4, 1),
('E004', '2024-11-18', '08:00', '12:00', 4, 1),
('E005', '2024-11-18', '12:00', '16:00', 4, 1),
('E006', '2024-11-18', '12:00', '16:00', 4, 1),
('E001', '2024-11-19', '08:00', '12:00', 4, 1),
('E002', '2024-11-19', '08:00', '12:00', 4, 1),
('E003', '2024-11-19', '12:00', '16:00', 4, 1),
('E010', '2024-11-19', '12:00', '16:00', 4, 1),
('E011', '2024-11-20', '08:00', '12:00', 4, 1),
('E001', '2024-11-20', '08:00', '12:00', 4, 1),
('E002', '2024-11-20', '12:00', '16:00', 4, 1),
('E003', '2024-11-20', '12:00', '16:00', 4, 1),
('E004', '2024-11-21', '08:00', '12:00', 4, 1),
('E005', '2024-11-21', '08:00', '12:00', 4, 1),
('E006', '2024-11-21', '12:00', '16:00', 4, 1),
('E004', '2024-11-21', '12:00', '16:00', 4, 1);

-- �s�W���b��
INSERT INTO checkout (checkout_id,invoice_number , customer_tel, employee_id, checkout_total_price,checkout_date,bonus_points,points_due_date, checkout_status, related_return_id)
VALUES
	('C00000001','IN00000001','0912345678', 'E001', 2060 , '2024-11-04',20, '2025-11-04','�w�h�f','T00000001'),
	('C00000002','IN00000002','', 'E002', 175 , '2024-11-04',0, '','�w�h�f','T00000002'),
	('C00000003','IN00000003','0912345678', 'E003', 1500 , '2024-11-04',15, '2025-11-04','�w�h�f','T00000003'),
	('C00000004','IN00000004','0923456789', 'E001', 4090 , '2024-11-04',40, '2025-11-04','���`',''),
	('C00000005','IN00000005','0934567890', 'E002', 565 , '2024-11-04',5, '2025-11-04','���`',''),
	('C00000006','IN00000006','0912345678', 'E004', 1860 , '2024-11-05',18, '2025-11-05','���`',''),
	('C00000007','IN00000007','', 'E005', 105 , '2024-11-06',0, '','���`',''),
	('C00000008','IN00000008','0912345678', 'E006', 750 , '2024-11-07',7, '2025-11-07','���`','');
	
-- �s�W���b����        
INSERT INTO checkout_details(checkout_id,product_id,number_of_checkout,product_price,checkout_price)
VALUES
	('C00000001', 'PMS001', 10, 200, 2000),
	('C00000001', 'PVF001', 3, 20, 60),
	('C00000002', 'PSN004', 5, 35, 175),
	('C00000003', 'PRN001', 8, 150, 1200),
	('C00000003', 'PDR001', 10, 30, 300),
	('C00000004', 'PMS002', 20, 200, 4000),
	('C00000004', 'PVF002', 3, 30, 90),
	('C00000005', 'PSN003', 5, 15, 75),
	('C00000005', 'PRN003', 8, 30, 240),
	('C00000005', 'PDR004', 10, 25, 250),
	('C00000006', 'PMS001', 9, 200, 1800),
	('C00000006', 'PVF001', 3, 20, 60),
	('C00000007', 'PSN004', 3, 35, 105),
	('C00000008', 'PRN001', 3, 150, 450),
	('C00000008', 'PDR001', 10, 30, 300);

-- �s�W�h�f��
INSERT INTO return_products (return_id,original_checkout_id,original_invoice_number, employee_id , return_total_price , return_date)
VALUES
	('T00000001', 'C00000001', 'IN00000001', 'E001', 200 , '2024-11-05'),
	('T00000002', 'C00000002', 'IN00000002', 'E002', 70,  '2024-11-06'),
	('T00000003', 'C00000003', 'IN00000003', 'E003', 750 , '2024-11-07');

-- �s�W�h�f����
INSERT INTO return_details(return_id,original_checkout_id,product_id,reason_for_return,number_of_return,product_price,return_price,return_status,return_photo) 
VALUES
('T00000001', 'C00000001', 'PMS001', '�ަׯ��',1, 200, 200,'�ӫ~�~�貧�`',NULL),
('T00000002', 'C00000002', 'PSN004' , 'Ĭ���氮�]�˧�������L����',2, 35, 70,'�ӫ~�~�[�l��',NULL),
('T00000003', 'C00000003','PRN001' , '�̸̭�����',5, 150, 750,'�ӫ~�~�貧�`',NULL);

-- �s�W���Q�I���ӫ~��
INSERT INTO bonus_exchange (exchange_id,product_id ,customer_tel ,use_points ,number_of_exchange,exchange_date )
VALUES
	('H00000001', 'PSN003', '0912345678', 15,1,'2024-11-08'),
	('H00000002', 'PVF001', '0923456789', 20,1,'2024-11-08');

-- �s�W���|���I�ư����Q�I���ӫ~����
INSERT INTO customer (customer_tel, customer_name, customer_email, date_of_registration, total_points)
VALUES
	('0955993322', '����', 'cus021@email.com', '2024-07-01', 500),
	('0933333333', '����', 'cus022@email.com', '2024-07-01', 200),
	('0911111111', '���p��', 'chenxm@email.com', '2024-01-05', 350),
	('0922222222', '�L����', 'linml@email.com', '2024-02-10', 400),
	('0977777777', '���j��', 'wangdw@email.com', '2024-03-15', 450),
	('0944444444', '�i�f��', 'zhanghm@email.com', '2024-04-20', 500),
	('0955555555', '����j', 'ligq@email.com', '2024-05-25', 600),
	('0966666666', '���l�s', 'zhaozl@email.com', '2024-06-30', 700);     

-- �s�W���Q������
INSERT INTO points_history (customer_tel ,checkout_id ,exchange_id ,points_change,transaction_date, transaction_type)
VALUES
	('0912345678', 'C00000001','', 20, '2024-11-04','earn'),
	('0912345678', 'C00000003','', 15, '2024-11-05','earn'),
	('0923456789', 'C00000004','', 40, '2024-11-06','earn'),
	('0912345678', 'C00000005','', 5, '2024-11-07','earn'),
	('0912345678','' ,'H00000001', 15, '2024-11-08','use'),
	('0923456789', '','H00000002', 20, '2024-11-08','use');
    
               

--======================================================================
-- ���\�ध���












--======================FK��========================

--�إ߽L�Iemployee_id���M���uemployee_id���~��
ALTER TABLE inventory_check 
ADD CONSTRAINT employee_id_FK
FOREIGN KEY (employee_id)
REFERENCES employee(employee_id);

--�إ߽L�Iinventory_check_id���M�L�I����inventory_check_id���~��
ALTER TABLE inventory_check_details 
ADD CONSTRAINT inventory_check_id_FK
FOREIGN KEY (inventory_check_id)
REFERENCES inventory_check(inventory_check_id);

--�إ߰ӫ~product_idd���M�L�I����product_id���~��
ALTER TABLE inventory_check_details 
ADD CONSTRAINT product_id_FK
FOREIGN KEY (product_id)
REFERENCES products(product_id);

-- �إ߭��u��position_id�P¾�Ū�position_id�~�����Y
ALTER TABLE employee
ADD CONSTRAINT position_id_FK
FOREIGN KEY (position_id)
REFERENCES ranklevel(position_id);

-- �إ߳q����employee_id�P���u��employee_id�~�����Y
ALTER TABLE notification
ADD CONSTRAINT employee_id_FK
FOREIGN KEY (employee_id)
REFERENCES employee(employee_id);

-- �إ߲�ѰT����employee_id�P���u��employee_id�~�����Y
ALTER TABLE chat_messages
ADD CONSTRAINT fk_from_user
FOREIGN KEY (from_user)
REFERENCES employee(employee_id)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE chat_messages
ADD CONSTRAINT fk_to_user
FOREIGN KEY (to_user)
REFERENCES employee(employee_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE schedule
ADD CONSTRAINT schedule_employee_id_FK
FOREIGN KEY (employee_id)
REFERENCES employee(employee_id);

ALTER TABLE schedule
ADD CONSTRAINT FK_shift_period
FOREIGN KEY (shift_id) REFERENCES shift_period(shift_id);

ALTER TABLE schedule
ADD CONSTRAINT FK_shift_quota
FOREIGN KEY (quota_id) REFERENCES shift_quota(quota_id);

ALTER TABLE shift_quota
ADD CONSTRAINT shift_quota_employee_id_FK
FOREIGN KEY (employee_id)
REFERENCES employee(employee_id);

-- �إ߽а���employee_id�P���u��employee_id�~�����Y
ALTER TABLE ask_for_leave
ADD CONSTRAINT ask_for_leave_employee_id_FK
FOREIGN KEY (employee_id)
REFERENCES employee(employee_id);

-- �إ߽а���category_id�P�а����O��category_id�~�����Y
ALTER TABLE ask_for_leave
ADD CONSTRAINT ask_for_leave_category_id_FK
FOREIGN KEY (category_id)
REFERENCES leave_category(category_id);

-- �~�����p����u�� employee_id
ALTER TABLE leave_record
ADD CONSTRAINT leave_record_employee_id_FK
FOREIGN KEY (employee_id)
REFERENCES employee(employee_id);

-- �~�����p��а����O�� category_id
ALTER TABLE leave_record
ADD CONSTRAINT leave_record_category_id_FK
FOREIGN KEY (category_id)
REFERENCES leave_category(category_id);

-- �]�w�i�f��employee_id�P���u��employee_id�إߥ~�����Y
ALTER TABLE restocks
ADD CONSTRAINT restocks_employee_id_FK
FOREIGN KEY (employee_id)
REFERENCES employee(employee_id);

-- �]�w�i�f���Ӫ�restock_id�Prestocks��restock_id�إߥ~�����Y
ALTER TABLE restock_details
ADD CONSTRAINT restock_details_restock_id_FK
FOREIGN KEY (restock_id)
REFERENCES restocks(restock_id);

-- �]�w�i�f���Ӫ�supplier_id�Psuppliers ��supplier_id�إߥ~�����Y
ALTER TABLE restock_details
ADD CONSTRAINT restock_details_supplier_id_FK
FOREIGN KEY (supplier_id)
REFERENCES suppliers(supplier_id);

-- �]�w�i�f���Ӫ�supplier_product_id�Psupplier_products ��supplier_product_id�إߥ~�����Y
ALTER TABLE restock_details
ADD CONSTRAINT restock_details_supplier_product_id_FK
FOREIGN KEY (supplier_product_id)
REFERENCES supplier_products(supplier_product_id);

-- �]�w�h�f��employee_id�P���u��employee_id�إߥ~�����Y
ALTER TABLE return_products
ADD CONSTRAINT return_products_employee_id_FK
FOREIGN KEY (employee_id)
REFERENCES employee(employee_id);

-- �]�w�h�f��original_checkout_id�P���b��checkout_id�إߥ~�����Y
ALTER TABLE return_products
ADD CONSTRAINT return_products_original_checkout_id_FK
FOREIGN KEY (original_checkout_id)
REFERENCES checkout(checkout_id);

-- �]�w�h�f��original_invoice_number�P���b��invoice_number�إߥ~�����Y
ALTER TABLE return_products
ADD CONSTRAINT return_products_original_invoice_number_FK
FOREIGN KEY (original_invoice_number)
REFERENCES checkout(invoice_number);

-- �]�w�h�f���Ӫ�return_id�P�h�f��return_id�إߥ~�����Y
ALTER TABLE return_details
ADD CONSTRAINT return_details_return_id_FK
FOREIGN KEY (return_id)
REFERENCES return_products(return_id);

-- �]�w�h�f���Ӫ�original_checkout_id�P���b���Ӫ�checkout_id�إߥ~�����Y
ALTER TABLE return_details
ADD CONSTRAINT return_details_original_checkout_id_FK
FOREIGN KEY (original_checkout_id)
REFERENCES checkout_details(checkout_id);

-- �]�w�h�f���Ӫ�product_id�P���b���Ӫ�product_id�إߥ~�����Y
ALTER TABLE return_details
ADD CONSTRAINT return_details_product_id_FK
FOREIGN KEY (product_id)
REFERENCES checkout_details(product_id);

-- �]�w���b��employee_id�P���u��employee_id�إߥ~�����Y
ALTER TABLE checkout
ADD CONSTRAINT checkout_employee_id_FK
FOREIGN KEY (employee_id)
REFERENCES employee(employee_id);

-- ���s�Ыإ~������A�u�b customer_tel ���� NULL �ɥͮ�
ALTER TABLE checkout
ADD CONSTRAINT checkout_customer_tel_FK
FOREIGN KEY (customer_tel)
REFERENCES customer(customer_tel)
ON DELETE SET NULL
ON UPDATE CASCADE;

-- ���s�Ыإ~������A�u�b related_return_id ���� NULL �ɥͮ�
ALTER TABLE checkout
ADD CONSTRAINT checkout_related_return_id_FK
FOREIGN KEY (related_return_id)
REFERENCES return_products(return_id)
ON DELETE SET NULL
ON UPDATE CASCADE;

-- �]�w���b���Ӫ�checkout_id�P���b��checkout_id�إߥ~�����Y
ALTER TABLE checkout_details
ADD CONSTRAINT checkout_details_checkout_id_FK
FOREIGN KEY (checkout_id)
REFERENCES checkout(checkout_id);

--ALTER TABLE checkout_details
--DROP CONSTRAINT checkout_details_checkout_id_FK;

-- �]�w���b���Ӫ�product_id�P�ӫ~��product_id�إߥ~�����Y
ALTER TABLE checkout_details
ADD CONSTRAINT checkout_details_product_id_FK
FOREIGN KEY (product_id)
REFERENCES products(product_id);

-- ���Q�I���ӫ~��product_id�P�ӫ~��product_id�إߥ~�����Y
ALTER TABLE bonus_exchange
ADD CONSTRAINT bonus_exchange_product_id_FK
FOREIGN KEY (product_id)
REFERENCES products(product_id);

-- ���Q�I���ӫ~��customer_tel�P�|����customer_tel�إߥ~�����Y
ALTER TABLE bonus_exchange
ADD CONSTRAINT bonus_exchange_customer_tel_FK
FOREIGN KEY (customer_tel)
REFERENCES customer(customer_tel);

-- �]�w���Q������customer_tel�P�|����customer_tel�~�����Y
ALTER TABLE points_history
ADD CONSTRAINT points_history_customer_tel_FK
FOREIGN KEY (customer_tel)
REFERENCES customer(customer_tel);

-- �]�w���Q������checkout_id�P���b��checkout_id�~�����Y
-- �Ыطs���~������A�u�b checkout_id ���� NULL �ɥͮ�
ALTER TABLE points_history
ADD CONSTRAINT points_history_checkout_id_FK
FOREIGN KEY (checkout_id)
REFERENCES checkout(checkout_id)
ON DELETE SET NULL
ON UPDATE CASCADE;

-- �]�w���Q������exchange_id�P�I���ӫ~��exchange_id�~�����Y
-- �Ыطs���~������A�u�b exchange_id ���� NULL �ɥͮ�
ALTER TABLE points_history
ADD CONSTRAINT points_history_exchange_id_FK
FOREIGN KEY (exchange_id)
REFERENCES bonus_exchange(exchange_id)
ON DELETE SET NULL
ON UPDATE CASCADE;

-- �K�[�ˬd�����A�T�O checkout_id �M exchange_id ���|�P�ɦ���
--ALTER TABLE points_history
--ADD CONSTRAINT CHK_points_history_id_exclusivity
--CHECK ((checkout_id IS NULL AND exchange_id IS NOT NULL) OR 
--       (checkout_id IS NOT NULL AND exchange_id IS NULL) OR 
--       (checkout_id IS NULL AND exchange_id IS NULL));

-- �]�w�����Ӱӫ~��supplier_id�Psuppliers ��supplier_id�~�����Y
ALTER TABLE supplier_products
ADD CONSTRAINT supplier_products_supplier_id_FK
FOREIGN KEY (supplier_id)
REFERENCES suppliers(supplier_id);

-- �]�w�����Ӱӫ~��product_id�Pproducts ��product_id�~�����Y
ALTER TABLE supplier_products
ADD CONSTRAINT supplier_products_product_id_FK
FOREIGN KEY (product_id)
REFERENCES products(product_id);

-- �]�w�����ӱb���supplier_id�Psuppliers ��supplier_id�~�����Y
ALTER TABLE supplier_accounts
ADD CONSTRAINT supplier_accounts_supplier_id_FK
FOREIGN KEY (supplier_id)
REFERENCES suppliers(supplier_id);

-- �]�w�I�ڰO����restock_id�Prestocks��restock_id�~�����Y
ALTER TABLE payment_records
ADD CONSTRAINT supplier_accounts_restock_id_FK
FOREIGN KEY (restock_id)
REFERENCES restocks(restock_id);



--======================================================================
SELECT * FROM products;
SELECT * FROM inventory_check;
SELECT * FROM inventory_check_details;
SELECT * FROM suppliers;
SELECT * FROM supplier_products;
SELECT * FROM supplier_accounts;
SELECT * FROM restocks;
SELECT * FROM restock_details;
SELECT * FROM payments;
SELECT * FROM payment_records;
SELECT * FROM return_details;
SELECT * FROM return_products;
SELECT * FROM checkout_details;
SELECT * FROM checkout;
SELECT * FROM ranklevel;
SELECT * FROM employee;
SELECT * FROM notification;
SELECT * FROM schedule;
SELECT * FROM ask_for_leave;
SELECT * FROM leave_record;
SELECT * FROM leave_category;
SELECT * FROM customer;
SELECT * FROM bonus_exchange;
SELECT * FROM points_history;

--TRUNCATE TABLE products;
--TRUNCATE TABLE inventory_check;
--TRUNCATE TABLE inventory_check_details;
--TRUNCATE TABLE suppliers
--TRUNCATE TABLE supplier_products
--TRUNCATE TABLE supplier_accounts
--TRUNCATE TABLE restocks
--TRUNCATE TABLE restock_details
--TRUNCATE TABLE payments
--TRUNCATE TABLE payment_records
--TRUNCATE TABLE return_details;
--TRUNCATE TABLE return_products;
--TRUNCATE TABLE checkout_details;
--TRUNCATE TABLE checkout;
--TRUNCATE TABLE ranklevel;
--TRUNCATE TABLE employee;
--TRUNCATE TABLE notification;
--TRUNCATE TABLE chat_messages;
--TRUNCATE TABLE schedule;
--TRUNCATE TABLE ask_for_leave;
--TRUNCATE TABLE leave_record;
--TRUNCATE TABLE leave_category;
--TRUNCATE TABLE customer;
--TRUNCATE TABLE bonus_exchange;
--TRUNCATE TABLE points_history;

DROP TABLE products;
DROP TABLE inventory_check;
DROP TABLE inventory_check_details;
DROP TABLE suppliers;
DROP TABLE supplier_products;
DROP TABLE supplier_accounts;
DROP TABLE restocks;
DROP TABLE restock_details;
DROP TABLE payments;
DROP TABLE payment_records;
DROP TABLE return_details;
DROP TABLE return_products;
DROP TABLE checkout_details;
DROP TABLE checkout;
DROP TABLE ranklevel;
DROP TABLE employee;
DROP TABLE notification;
DROP TABLE chat_messages;
DROP TABLE schedule;
DROP TABLE ask_for_leave;
DROP TABLE leave_record;
DROP TABLE leave_category;
DROP TABLE customer;
DROP TABLE bonus_exchange;
DROP TABLE points_history;