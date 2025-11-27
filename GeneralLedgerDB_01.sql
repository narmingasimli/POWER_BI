CREATE DATABASE GeneralLedgerDB;
GO
---------------------------------------------------------------------------
-----------Accounts (Hesablar cədvəli)-------------------------------------
CREATE TABLE GL_Accounts (
    AccountID INT PRIMARY KEY IDENTITY(1,1), -- Unikal ID
    AccountName NVARCHAR(100) NOT NULL, -- Hesab adı
    AccountType NVARCHAR(50) NOT NULL, -- Aktiv, Passiv, Kapital və s.
    OpeningBalance DECIMAL(18, 2) DEFAULT 0, -- Hesabın açılış balansı
    CurrentBalance DECIMAL(18, 2) DEFAULT 0, -- Hesabın cari balansı
    CreatedDate DATETIME DEFAULT GETDATE() -- Yaradılma tarixi
);

INSERT INTO GL_Accounts (AccountName, AccountType, OpeningBalance)
VALUES 
    ('Bank Account', 'Asset', 10000.00),
    ('Sales Revenue', 'Revenue', 0.00),
    ('Office Expenses', 'Expense', 0.00),
    ('Owner’s Equity', 'Equity', 5000.00);

SELECT * FROM GL_Accounts
---------------------------------------------------------------------------
-----------Transactions (Əməliyyatlar cədvəli) yarat-----------------------
CREATE TABLE GL_Transactions (
    TransactionID INT PRIMARY KEY IDENTITY(1,1), -- Unikal ID
    AccountID INT NOT NULL, -- Hansi hesaba aid oldugu
    Debit DECIMAL(18, 2) DEFAULT 0, -- Debit məbləği
    Credit DECIMAL(18, 2) DEFAULT 0, -- Kredit məbləği
    TransactionDate DATETIME DEFAULT GETDATE(), -- Əməliyyat tarixi
    Description NVARCHAR(255), -- Əməliyyat təsviri
    FOREIGN KEY (AccountID) REFERENCES GL_Accounts(AccountID) -- Xarici açar
);

INSERT INTO GL_Transactions (AccountID, Debit, Credit, Description)
VALUES
    (1, 0, 2000.00, 'Payment for Office Supplies'),
    (3, 2000.00, 0, 'Office Supplies Purchase'),
    (2, 0, 5000.00, 'Revenue from Sales'),
    (1, 5000.00, 0, 'Sales Revenue deposited into Bank');

SELECT * FROM GL_Transactions
---------------------------------------------------------------------------
-----------Journals (Jurnal qeydləri cədvəli)------------------------------
CREATE TABLE GL_Journals (
    JournalID INT PRIMARY KEY IDENTITY(1,1), -- Unikal ID
    JournalName NVARCHAR(100) NOT NULL, -- Jurnalın adı
    JournalDate DATETIME DEFAULT GETDATE(), -- Jurnal tarixi
    CreatedBy NVARCHAR(50) NOT NULL -- Jurnalı yaradan istifadəçi
);

INSERT INTO GL_Journals (JournalName, CreatedBy)
VALUES 
    ('January 2025 Transactions', 'Admin'),
    ('February 2025 Transactions', 'Admin');

SELECT * FROM GL_Journals
---------------------------------------------------------------------------
-----------Users (İstifadəçilər cədvəli)-----------------------------------
CREATE TABLE GL_Users (
    UserID INT PRIMARY KEY IDENTITY(1,1), -- Unikal ID
    Username NVARCHAR(50) NOT NULL, -- İstifadəçi adı
    PasswordHash NVARCHAR(255) NOT NULL, -- Şifrənin kodlaşdırılmış forması
    Role NVARCHAR(50) NOT NULL, -- İstifadəçinin rolu (Admin, Mühasib)
    CreatedDate DATETIME DEFAULT GETDATE() -- Yaradılma tarixi
);

INSERT INTO GL_Users (Username, PasswordHash, Role)
VALUES 
    ('admin', 'hashed_password_123', 'Admin'),
    ('accountant', 'hashed_password_456', 'Accountant');

SELECT * FROM GL_Users
---------------------------------------------------------------------------
SELECT * FROM GL_Accounts
SELECT * FROM GL_Transactions
SELECT * FROM GL_Journals
SELECT * FROM GL_Users
---------------------------------------------------------------------------
-----------Hər hesabın balansını əldə et-----------------------------------
SELECT 
    t.AccountID,
    a.AccountName,
    SUM(t.Debit - t.Credit) AS NetBalance
FROM GL_Transactions t
JOIN GL_Accounts a ON t.AccountID = a.AccountID
GROUP BY t.AccountID, a.AccountName;
---------------------------------------------------------------------------
-----------Müəyyən tarix aralığındakı əməliyyatları əldə et----------------
SELECT 
    TransactionID,
    AccountID,
    Debit,
    Credit,
    TransactionDate,
    Description
FROM GL_Transactions
WHERE TransactionDate BETWEEN '2025-01-01' AND '2025-01-31';
---------------------------------------------------------------------------
-----------Ən yüksək gəlir gətirən hesabı tap------------------------------
SELECT TOP 1 
    GL_Accounts.AccountID, 
    GL_Accounts.AccountName, 
    SUM(GL_Transactions.Credit) AS TotalCredit
FROM GL_Transactions
JOIN GL_Accounts 
    ON GL_Transactions.AccountID = GL_Accounts.AccountID
WHERE GL_Accounts.AccountType = 'Revenue'
GROUP BY GL_Accounts.AccountID, GL_Accounts.AccountName
ORDER BY TotalCredit DESC;

















---------------------------------------------------------------------------
-----------

---------------------------------------------------------------------------
-----------

---------------------------------------------------------------------------
-----------
































select '3' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '3.30' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '3.30.301' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '3.30.301.01' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '3.30.301.01.01' Logo_account_number, 'Share capital' Disclosure_line, 'Share capital' FS_line union all
select '3.30.302' Logo_account_number, 'Paid-up share capital' Disclosure_line, 'Share Capital' FS_line union all
select '3.31' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '3.31.311' Logo_account_number, 'Share premium' Disclosure_line, 'Share premium' FS_line union all
select '3.32' Logo_account_number, '' Disclosure_line, '' FS_line union all
select '3.32.321' Logo_account_number, 'Bought back shares' Disclosure_line, 'Bought back shares' FS_line union all
select '3.33' Logo_account_number, '' Disclosure_line, 'Revaluation surplus' FS_line union all
select '3.33.331' Logo_account_number, 'Revaluation surplus' Disclosure_line, 'Revaluation surplus' FS_line union all
select '3.33.332' Logo_account_number, 'Reserve for currency' Disclosure_line, 'Revaluation surplus' FS_line union all
select '3.33.333' Logo_account_number, 'Reserve for changes in legislation' Disclosure_line, 'Revaluation surplus' FS_line union all
select '3.33.334' Logo_account_number, 'Reserve for share capital' Disclosure_line, 'Revaluation surplus' FS_line union all
select '3.33.335' Logo_account_number, 'Other reserves' Disclosure_line, 'Revaluation surplus' FS_line union all
select '3.34' Logo_account_number, '' Disclosure_line, '' FS_line


















