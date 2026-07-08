CREATE DATABASE [DB_ECOMMERCE]
GO

USE [DB_ECOMMERCE]
GO

CREATE SCHEMA [SQM_GENERAL]
GO

CREATE SCHEMA [SQM_CATALOGS]
GO

CREATE SCHEMA [SQM_SECURITY]
GO

CREATE TABLE [SQM_CATALOGS].[Tbl_Status]
(
	statusId INT PRIMARY KEY IDENTITY (1,1),
	statusName VARCHAR(50) NOT NULL,
	statusCreatorId INT,
	statusCreationDate DATETIME NOT NULL,
	statusModificatorId INT,
	statusModificationDate DATETIME NULL,
	statusStatusId BIT NOT NULL
);

CREATE TABLE [SQM_SECURITY].[Tbl_Users]
(
	userId INT PRIMARY KEY IDENTITY (1,1),
	userFullName VARCHAR(100) NOT NULL,
	userName VARCHAR(50) NOT NULL,
	userPassword VARBINARY(256) NOT NULL,
	userEmail VARCHAR(80) NOT NULL,
	userPhoneNumber VARCHAR(20) NOT NULL,
	userCountryId INT NOT NULL,
	userGenderId INT NOT NULL,
	userBirthDay DATE NOT NULL,
	userCreatorId INT NOT NULL,
	userCreationDate DATETIME NOT NULL,
	userModificatorId INT NULL,
	userModificationDate DATETIME NULL,
	userStatusId INT REFERENCES [SQM_CATALOGS].[Tbl_Status](statusId) NOT NULL
);

-- ALT + SHIFT + DIRECCIONAL
CREATE TABLE [SQM_GENERAL].[Tbl_UserAddress]
(
	userAddressId INT PRIMARY KEY IDENTITY (1,1),
	userAddressUserId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	userAddressCountryId INT NOT NULL,
	userAddressZIPCode INT NOT NULL,
	userAddressDescription NVARCHAR(500) NOT NULL,
	userAddressIsPrincipal BIT NOT NULL,
	userAddressCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	userAddressCreationDate DATETIME NOT NULL,
	userAddressModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	userAddressModificationDate DATETIME NULL,
	userAddressStatusId BIT NOT NULL
);

CREATE TABLE [SQM_CATALOGS].[Tbl_Categories]
(
	categoryId INT PRIMARY KEY IDENTITY (1,1),
	categoryName VARCHAR(50) NOT NULL,
	categoryDescription VARCHAR(100) NOT NULL,
	categoryCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	categoryCreationDate DATETIME NOT NULL,
	categoryModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	categoryModificationDate DATETIME NULL,
	categoryStatusId BIT NOT NULL
);

CREATE TABLE [SQM_CATALOGS].[Tbl_SubCategories]
(
	subCategoryId INT PRIMARY KEY IDENTITY (1,1),
	subCategoryName VARCHAR(50) NOT NULL,
	subCategoryDescription VARCHAR(100) NOT NULL,
	subCategoryCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	subCategoryCreationDate DATETIME NOT NULL,
	subCategoryModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	subCategoryModificationDate DATETIME NULL,
	subCategoryStatusId BIT NOT NULL
);

CREATE TABLE [SQM_CATALOGS].[Tbl_Segments]
(
	segmentId INT PRIMARY KEY IDENTITY (1,1),
	segmentName VARCHAR(50) NOT NULL,
	segmentDescription VARCHAR(100) NOT NULL,
	segmentCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	segmentCreationDate DATETIME NOT NULL,
	segmentModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	segmentModificationDate DATETIME NULL,
	segmentStatusId BIT NOT NULL
);

CREATE TABLE [SQM_CATALOGS].[Tbl_ProductIdentificators]
(
	productIdentificatorId INT PRIMARY KEY IDENTITY(1,1),
	productIdentificatorCategoryId INT REFERENCES [SQM_CATALOGS].[Tbl_Categories](categoryId) NOT NULL,
	productIdentificatorSubCategoryId INT REFERENCES [SQM_CATALOGS].[Tbl_SubCategories](subCategoryId) NOT NULL,
	productIdentificatorSegmentId INT REFERENCES [SQM_CATALOGS].[Tbl_Segments](segmentId) NOT NULL,
	productIdentificatorCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	productIdentificatorCreationDate DATETIME NOT NULL,
	productIdentificatorModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	productIdentificatorModificationDate DATETIME NULL,
	productIdentificatorStatusId BIT NOT NULL
);

CREATE TABLE [SQM_CATALOGS].[Tbl_Providers]
(
	providerId INT PRIMARY KEY IDENTITY (1,1),
	providerName VARCHAR(50) NOT NULL,
	providerDescription VARCHAR(100) NOT NULL,
	providerCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	providerCreationDate DATETIME NOT NULL,
	providerModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	providerModificationDate DATETIME NULL,
	providerStatusId BIT NOT NULL
);

CREATE TABLE [SQM_CATALOGS].[Tbl_Marks]
(
	markId INT PRIMARY KEY IDENTITY (1,1),
	markName VARCHAR(50) NOT NULL,
	markDescription VARCHAR(100) NOT NULL,
	markCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	markCreationDate DATETIME NOT NULL,
	markModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	markModificationDate DATETIME NULL,
	markStatusId BIT NOT NULL
);

CREATE TABLE [SQM_CATALOGS].[Tbl_MarkByProviders]
(
	markByProviderId INT PRIMARY KEY IDENTITY(1,1),
	markByProviderMarkId INT REFERENCES [SQM_CATALOGS].[Tbl_Marks](markId) NOT NULL,
	markByProviderProviderId INT REFERENCES [SQM_CATALOGS].[Tbl_Providers](providerId) NOT NULL,
	markByProviderCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	markByProviderCreationDate DATETIME NOT NULL,
	markByProviderModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	markByProviderModificationDate DATETIME NULL,
	markByProviderStatusId BIT NOT NULL
);

CREATE TABLE [SQM_CATALOGS].[Tbl_AttributesTypes]
(
	attributeTypeId INT PRIMARY KEY IDENTITY (1,1),
	attributeTypeName VARCHAR(50) NOT NULL,
	attributeTypeDescription VARCHAR(100) NOT NULL,
	attributeTypeCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	attributeTypeCreationDate DATETIME NOT NULL,
	attributeTypeModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	attributeTypeModificationDate DATETIME NULL,
	attributeTypeStatusId BIT NOT NULL
);

CREATE TABLE [SQM_CATALOGS].[Tbl_Currencies]
(
	currencyId INT PRIMARY KEY IDENTITY (1,1),
	currencyName VARCHAR(50) NOT NULL,
	currencyISO CHAR(5) NOT NULL,
	currencyCode INT NOT NULL,
	currencyDescription VARCHAR(100) NOT NULL,
	currencyCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	currencyCreationDate DATETIME NOT NULL,
	currencyModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	currencyModificationDate DATETIME NULL,
	currencyStatusId BIT NOT NULL
);

CREATE TABLE [SQM_GENERAL].[Tbl_Products]
(
	productId INT PRIMARY KEY IDENTITY (1,1),
	productName VARCHAR(50) NOT NULL,
	productDescription VARCHAR(200) NOT NULL,
	productProductIdentificatorId INT REFERENCES [SQM_CATALOGS].[Tbl_ProductIdentificators](productIdentificatorId) NOT NULL,
	productMarkByProviderId INT REFERENCES [SQM_CATALOGS].[Tbl_MarkByProviders](markByProviderId) NOT NULL,
	productCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	productCreationDate DATETIME NOT NULL,
	productModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	productModificationDate DATETIME NULL,
	productStatusId BIT NOT NULL
);

CREATE TABLE [SQM_CATALOGS].[Tbl_AttributeProducts]
(
	AttributeProductId INT PRIMARY KEY IDENTITY (1,1),
	AttributeProductAttributesTypeId INT REFERENCES [SQM_CATALOGS].[Tbl_AttributesTypes](attributeTypeId) NOT NULL,
	AttributeProductName VARCHAR(50) NOT NULL,
	AttributeProductDescription VARCHAR(100) NOT NULL,
	AttributeProductCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	AttributeProductCreationDate DATETIME NOT NULL,
	AttributeProductModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	AttributeProductModificationDate DATETIME NULL,
	AttributeProductStatusId BIT NOT NULL
);

CREATE TABLE [SQM_GENERAL].[Tbl_ProductImages]
(
	productImageId INT PRIMARY KEY IDENTITY (1,1),
	productImageProductId INT REFERENCES [SQM_GENERAL].[Tbl_Products](productId) NOT NULL,
	productImageURL VARCHAR(200) NOT NULL,
	productImageDescription VARCHAR(100) NOT NULL,
	productImageIsPrincipal BIT NOT NULL,
	productImageCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	productImageCreationDate DATETIME NOT NULL,
	productImageModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	productImageModificationDate DATETIME NULL,
	productImageStatusId BIT NOT NULL
);

CREATE TABLE [SQM_CATALOGS].[Tbl_ProductVariableTypes]
(
	productVariableTypeId INT PRIMARY KEY IDENTITY (1,1),
	productVariableTypeName VARCHAR(50) NOT NULL,
	productVariableTypeDescription VARCHAR(100) NOT NULL,
	productVariableTypeCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	productVariableTypeCreationDate DATETIME NOT NULL,
	productVariableTypeModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	productVariableTypeModificationDate DATETIME NULL,
	productVariableTypeStatusId BIT NOT NULL
);

CREATE TABLE [SQM_GENERAL].[Tbl_ProductVariables]
(
	productVariableId INT PRIMARY KEY IDENTITY (1,1),
	productVariableProductId INT REFERENCES [SQM_GENERAL].[Tbl_Products](productId) NOT NULL,
	productVariableValue VARCHAR(50) NOT NULL,
	productVariablePrice DECIMAL(18,2) NOT NULL,
	productVariableCurrencyId INT REFERENCES [SQM_CATALOGS].[Tbl_Currencies](currencyId) NOT NULL,
	productVariableCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	productVariableCreationDate DATETIME NOT NULL,
	productVariableModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	productVariableModificationDate DATETIME NULL,
	productVariableStatusId BIT NOT NULL
);

CREATE TABLE [SQM_GENERAL].[Tbl_AttributeProductVariables]
(
	attributeProductVariableId INT PRIMARY KEY IDENTITY (1,1),
	attributeProductVariableProductVariableId INT REFERENCES [SQM_GENERAL].[Tbl_ProductVariables] NOT NULL,
	attributeProductVariableAttributeProductId INT REFERENCES [SQM_CATALOGS].[Tbl_ProductVariableTypes](productVariableTypeId) NOT NULL,
	attributeProductVariableValue VARCHAR(50) NOT NULL,
	attributeProductVariableCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	attributeProductVariableCreationDate DATETIME NOT NULL,
	attributeProductVariableModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	attributeProductVariableModificationDate DATETIME NULL,
	attributeProductVariableStatusId BIT NOT NULL
);

CREATE TABLE [SQM_GENERAL].[Tbl_Stocks]
(
	stockId INT PRIMARY KEY IDENTITY (1,1),
	stockProductVariableId INT REFERENCES [SQM_GENERAL].[Tbl_ProductVariables](productVariableId) NOT NULL,
	stockQuantity INT NOT NULL,
	stockFactoryDate DATE NOT NULL,
	stockExpirationDate DATE NOT NULL,
	stockCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	stockCreationDate DATETIME NOT NULL,
	stockModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	stockModificationDate DATETIME NULL,
	stockStatusId BIT NOT NULL
);

CREATE TABLE [SQM_GENERAL].[Tbl_Carts]
(
	cartId INT PRIMARY KEY IDENTITY (1,1),
	cartUserId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	cartCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	cartCreationDate DATETIME NOT NULL,
	cartModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	cartModificationDate DATETIME NULL,
	cartStatusId BIT NOT NULL
);

CREATE TABLE [SQM_GENERAL].[Tbl_CartDetails]
(
	cartDetailId INT PRIMARY KEY IDENTITY (1,1),
	cartDetailCartId INT REFERENCES [SQM_GENERAL].[Tbl_Carts](cartId) NOT NULL,
	cartDetailProductVariableId INT REFERENCES [SQM_GENERAL].[Tbl_ProductVariables](productVariableId) NOT NULL,
	cartDetailPrice DECIMAL(18,2) NOT NULL,
	cartDetailQuantity INT NOT NULL,
	cartDetailDiscount DECIMAL(18,2) NOT NULL,
	cartDetailSubTotal DECIMAL(18,2) NOT NULL,
	cartDetailTAX DECIMAL(18,2) NOT NULL,
	cartDetailTotal DECIMAL(18,2) NOT NULL,
	cartDetailCurrencyId INT REFERENCES [SQM_CATALOGS].[Tbl_Currencies](currencyId) NOT NULL,
	cartDetailCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	cartDetailCreationDate DATETIME NOT NULL,
	cartDetailModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	cartDetailModificationDate DATETIME NULL,
	cartDetailStatusId BIT NOT NULL
);

CREATE TABLE [SQM_CATALOGS].[Tbl_PaymentMethodTypes]
(
	paymentMethodTypeId INT PRIMARY KEY IDENTITY (1,1),
	paymentMethodTypeName VARCHAR(50) NOT NULL,
	paymentMethodTypeDescription VARCHAR(100) NOT NULL,
	paymentMethodTypeCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	paymentMethodTypeCreationDate DATETIME NOT NULL,
	paymentMethodTypeModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	paymentMethodTypeModificationDate DATETIME NULL,
	paymentMethodTypeStatusId BIT NOT NULL
);

CREATE TABLE [SQM_GENERAL].[Tbl_UserPaymentMethods]
(
	userPaymentMethodId INT PRIMARY KEY IDENTITY (1,1),
	userPaymentMethodUserId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	userPaymentMethodPaymentMethodTypeId INT REFERENCES [SQM_CATALOGS].[Tbl_PaymentMethodTypes](paymentMethodTypeId) NOT NULL,
	userPaymentMethodCardNumber VARBINARY(256) NOT NULL,
	userPaymentMethodExpirationDate VARBINARY(256) NOT NULL,
	userPaymentMethodCVV VARBINARY(256) NOT NULL,
	userPaymentMethodCardHolderName VARCHAR(100) NOT NULL,
	userPaymentMethodCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	userPaymentMethodCreationDate DATETIME NOT NULL,
	userPaymentMethodModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	userPaymentMethodModificationDate DATETIME NULL,
	userPaymentMethodStatusId BIT NOT NULL
);

CREATE TABLE [SQM_GENERAL].[Tbl_PaymentOrders]
(
	orderId INT PRIMARY KEY IDENTITY (1,1),
	orderUserId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	orderDeliveryAddress INT REFERENCES [SQM_GENERAL].[Tbl_UserAddress](userAddressId) NOT NULL,
	orderPaymentMethodId INT REFERENCES [SQM_GENERAL].[Tbl_UserPaymentMethods](userPaymentMethodId) NOT NULL,
	orderSubtotal DECIMAL(18,2) NOT NULL,
	orderDiscount DECIMAL(18,2) NOT NULL,
	orderShipping DECIMAL(18,2) NOT NULL,
	orderTAX DECIMAL(18,2) NOT NULL,
	orderTotal DECIMAL(18,2) NOT NULL,
	orderCurrencyId INT REFERENCES [SQM_CATALOGS].[Tbl_Currencies](currencyId) NOT NULL,
	orderCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	orderCreationDate DATETIME NOT NULL,
	orderModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	orderModificationDate DATETIME NULL,
	orderStatusId INT REFERENCES [SQM_CATALOGS].[Tbl_Status](statusId) NOT NULL
);

CREATE TABLE [SQM_GENERAL].[Tbl_PaymentOrderDetails]
(
	orderDetailId INT PRIMARY KEY IDENTITY (1,1),
	orderDetailOrderId INT REFERENCES [SQM_GENERAL].[Tbl_PaymentOrders](orderId) NOT NULL,
	orderDetailProductVariableId INT REFERENCES [SQM_GENERAL].[Tbl_ProductVariables](productVariableId) NOT NULL,
	orderDetailPrice DECIMAL(18,2) NOT NULL,
	orderDetailQuantity INT NOT NULL,
	orderDetailDiscount DECIMAL(18,2) NOT NULL,
	orderDetailSubTotal DECIMAL(18,2) NOT NULL,
	orderDetailTAX DECIMAL(18,2) NOT NULL,
	orderDetailTotal DECIMAL(18,2) NOT NULL,
	orderDetailCurrencyId INT REFERENCES [SQM_CATALOGS].[Tbl_Currencies](currencyId) NOT NULL,
	orderDetailCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	orderDetailCreationDate DATETIME NOT NULL,
	orderDetailModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	orderDetailModificationDate DATETIME NULL,
	orderDetailStatusId BIT NOT NULL
);

CREATE TABLE [SQM_CATALOGS].[Tbl_StockMovementTypes]
(
	stockMovementTypeId INT PRIMARY KEY IDENTITY (1,1),
	stockMovementTypeName VARCHAR(50) NOT NULL,
	stockMovementTypeDescription VARCHAR(100) NOT NULL,
	stockMovementTypeCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
	stockMovementTypeCreationDate DATETIME NOT NULL,
	stockMovementTypeModificatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
	stockMovementTypeModificationDate DATETIME NULL,
	stockMovementTypeStatusId BIT NOT NULL
);

CREATE TABLE [SQM_GENERAL].[Tbl_StockMovements]
(
    stockMovementId INT PRIMARY KEY IDENTITY(1,1),
    stockMovementTypeId INT REFERENCES [SQM_CATALOGS].[Tbl_StockMovementTypes](stockMovementTypeId) NOT NULL,
    stockMovementOrderId INT REFERENCES [SQM_GENERAL].[Tbl_PaymentOrders](orderId), -- FK to order
    stockMovementReference NVARCHAR(100),
    stockMovementCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
    stockMovementCreationDate DATETIME NOT NULL,
    stockMovementModifierId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
    stockMovementModificationDate DATETIME NULL,
    stockMovementStatusId INT REFERENCES [SQM_CATALOGS].[Tbl_Status](statusId) NOT NULL
);

CREATE TABLE [SQM_GENERAL].[Tbl_StockMovementDetails]
(
    stockMovementDetailId INT PRIMARY KEY IDENTITY(1,1),
    stockMovementDetailMovementId INT REFERENCES [SQM_GENERAL].[Tbl_StockMovements](stockMovementId) NOT NULL,
    stockMovementDetailOrderDetailId INT REFERENCES [SQM_GENERAL].[Tbl_PaymentOrderDetails](orderDetailId) NULL,
    stockMovementDetailProductVariableId INT REFERENCES [SQM_GENERAL].[Tbl_ProductVariables](productVariableId) NULL,
	stockMovementDetailStockId INT REFERENCES [SQM_GENERAL].[Tbl_Stocks](stockId) NULL,
    stockMovementDetailQuantity INT NOT NULL,
	stockMovementDetailFactoryDate DATE NULL,
	stockMovementDetailExpirationDate DATE NULL,
    stockMovementDetailCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
    stockMovementDetailCreationDate DATETIME NOT NULL,
    stockMovementDetailModifierId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
    stockMovementDetailModificationDate DATETIME NULL,
    stockMovementDetailStatusId BIT NOT NULL
);

CREATE TABLE [SQM_SECURITY].[Tbl_Roles]
(
	RolId INT PRIMARY KEY IDENTITY(1,1),
	RolName VARCHAR(50) NOT NULL,
	RolDescription VARCHAR(255) NOT NULL,
	RolCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
    RolCreationDate DATETIME NOT NULL,
    RolModifierId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
    RolModificationDate DATETIME NULL,
    RolStatusId BIT NOT NULL
);

CREATE TABLE [SQM_SECURITY].[Tbl_TransactionTypes]
(
	TransactionTypeId INT PRIMARY KEY IDENTITY(1,1),
	TransactionTypeName VARCHAR(50) NOT NULL,
	TransactionTypeDescription VARCHAR(255) NOT NULL,
	TransactionTypeCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
    TransactionTypeCreationDate DATETIME NOT NULL,
    TransactionTypeModifierId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
    TransactionTypeModificationDate DATETIME NULL,
    TransactionTypeStatusId BIT NOT NULL
);

CREATE TABLE [SQM_SECURITY].[Tbl_RolByTransactionTypes]
(
	RolByTransactionTypeId INT PRIMARY KEY IDENTITY(1,1),
	RolByTransactionRolId INT REFERENCES [SQM_SECURITY].[Tbl_Roles](RolId) NOT NULL,
	RolByTransactionTransactionTypeId INT REFERENCES [SQM_SECURITY].[Tbl_TransactionTypes](TransactionTypeId) NOT NULL,
	RolByTransactionTypeCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
    RolByTransactionTypeCreationDate DATETIME NOT NULL,
    RolByTransactionTypeModifierId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
    RolByTransactionTypeModificationDate DATETIME NULL,
    RolByTransactionTypeStatusId BIT NOT NULL
);

CREATE TABLE [SQM_SECURITY].[Tbl_UserByRoles]
(
	UserByRolId INT PRIMARY KEY IDENTITY(1,1),
	UserByRolRolId INT REFERENCES [SQM_SECURITY].[Tbl_Roles](RolId) NOT NULL,
	UserByRolUserId INT REFERENCES [SQM_SECURITY].[Tbl_Users](UserId) NOT NULL,
	UserByRolTypeCreatorId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId) NOT NULL,
    UserByRolTypeCreationDate DATETIME NOT NULL,
    UserByRolTypeModifierId INT REFERENCES [SQM_SECURITY].[Tbl_Users](userId),
    UserByRolTypeModificationDate DATETIME NULL,
    UserByRolTypeStatusId BIT NOT NULL
);

CREATE OR ALTER VIEW [SQM_CATALOGS].[VW_PRODUCT_IDENTIFICATORS]
AS
SELECT
[PI].[productIdentificatorId],
[C].[categoryId],
[C].[categoryName],
[C].[categoryDescription],
[SC].[subCategoryId],
[SC].[subCategoryName],
[SC].[subCategoryDescription],
[S].[segmentId],
[S].[segmentName],
[S].[segmentDescription]
FROM [SQM_CATALOGS].[Tbl_ProductIdentificators] [PI]
INNER JOIN [SQM_CATALOGS].[Tbl_Categories] [C] ON [PI].[productIdentificatorCategoryId] = [C].[categoryId]
INNER JOIN [SQM_CATALOGS].[Tbl_SubCategories] [SC] ON [PI].[productIdentificatorSubCategoryId] = [SC].[subCategoryId]
INNER JOIN [SQM_CATALOGS].[Tbl_Segments] [S] ON [PI].[productIdentificatorSegmentId] = [S].[segmentId]
WHERE
	[C].[categoryStatusId] = 1 AND
	[SC].[subCategoryStatusId] = 1 AND
	[S].[segmentStatusId] = 1 AND
	[PI].[productIdentificatorStatusId] = 1
GO

CREATE OR ALTER VIEW SQM_GENERAL.VW_GENERAL_PRODUCTS
AS
SELECT
	P.productId [ProductID],
	P.productName [ProductName],
	VP.productVariableId [ProductVariableID],
	VP.productVariableValue [ProductVariableName],
	VP.productVariablePrice [ProductVariablePrice],
	C.currencyId [CurrencyID],
	C.currencyISO [CurrencyISO],
	GP.categoryId [CategoryID],
	GP.categoryName [CategoryName],
	GP.subCategoryId [SubcategoryID],
	GP.subCategoryName [SubcategoryName],
	GP.segmentId [SegmentID],
	GP.segmentName [SegmentName],
	M.markId [MarkID],
	M.markName [MarkName],
	PR.providerId [ProviderID],
	PR.providerName [ProviderName],
	ST.stockId [StockID],
	ST.stockQuantity [StockAvilable],
	ST.stockFactoryDate [StockFactoryDate],
	ST.stockExpirationDate [StockExpirationDate]
FROM SQM_GENERAL.Tbl_Products (NOLOCK) P
INNER JOIN SQM_GENERAL.Tbl_ProductVariables (NOLOCK) VP
	ON P.productId = VP.productVariableProductId AND VP.productVariableStatusId = 1
INNER JOIN SQM_CATALOGS.Tbl_Currencies (NOLOCK) C
	ON VP.productVariableCurrencyId = C.currencyId AND C.currencyStatusId = 1
INNER JOIN [SQM_CATALOGS].[VW_PRODUCT_IDENTIFICATORS] (NOLOCK) GP
	ON P.productProductIdentificatorId = GP.productIdentificatorId
INNER JOIN SQM_CATALOGS.Tbl_MarkByProviders (NOLOCK) MxP
	ON P.productMarkByProviderId = MxP.markByProviderId AND MxP.markByProviderStatusId = 1
INNER JOIN SQM_CATALOGS.Tbl_Marks (NOLOCK) M
	ON MxP.markByProviderMarkId = M.markId AND M.markStatusId = 1
INNER JOIN SQM_CATALOGS.Tbl_Providers (NOLOCK) PR
	ON MxP.markByProviderProviderId = PR.providerId AND PR.providerStatusId = 1
INNER JOIN SQM_GENERAL.Tbl_Stocks (NOLOCK) ST
	ON VP.productVariableId = ST.stockProductVariableId AND ST.stockStatusId = 1
WHERE P.productStatusId = 1

USE DB_ECOMMERCE
GO

CREATE OR ALTER PROCEDURE SP_SearchProducts
(
    @i_FilterText VARCHAR(100),
    @o_ResultCode INT OUTPUT,
    @o_ResultMessage VARCHAR(500) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF ISNULL(LTRIM(RTRIM(@i_FilterText)), '') = ''
        BEGIN
            SET @o_ResultCode = 400;
            SET @o_ResultMessage = 'Debe ingresar un criterio de búsqueda.';
            RETURN;
        END

        SELECT
            ProductID,
            ProductName,
            ProductVariableID,
            ProductVariableName,
            ProductVariablePrice,
            CurrencyID,
            CurrencyISO,
            CategoryID,
            CategoryName,
            SubcategoryID,
            SubcategoryName,
            SegmentID,
            SegmentName,
            MarkID,
            MarkName,
            ProviderID,
            ProviderName,
            StockID,
            StockAvilable,
            StockFactoryDate,
            StockExpirationDate
        FROM SQM_GENERAL.VW_GENERAL_PRODUCTS
        WHERE
                ProductName LIKE '%' + @i_FilterText + '%'
            OR  ProductVariableName LIKE '%' + @i_FilterText + '%'
            OR  CategoryName LIKE '%' + @i_FilterText + '%'
            OR  SubcategoryName LIKE '%' + @i_FilterText + '%'
            OR  SegmentName LIKE '%' + @i_FilterText + '%'
            OR  MarkName LIKE '%' + @i_FilterText + '%'
            OR  ProviderName LIKE '%' + @i_FilterText + '%'
            OR  CurrencyISO LIKE '%' + @i_FilterText + '%';

        SET @o_ResultCode = 200;
        SET @o_ResultMessage = 'Consulta realizada correctamente.';

    END TRY
    BEGIN CATCH

        SET @o_ResultCode = 500;
        SET @o_ResultMessage =
            'Error SQL: ' + ERROR_MESSAGE();

    END CATCH
END
GO

INSERT INTO SQM_CATALOGS.Tbl_Status
(
    statusName,
    statusCreatorId,
    statusCreationDate,
    statusStatusId
)
VALUES
(
    'Activo',
    NULL,
    GETDATE(),
    1
);
SET IDENTITY_INSERT SQM_SECURITY.Tbl_Users ON;

INSERT INTO SQM_SECURITY.Tbl_Users
(
    userId,
    userFullName,
    userName,
    userPassword,
    userEmail,
    userPhoneNumber,
    userCountryId,
    userGenderId,
    userBirthDay,
    userCreatorId,
    userCreationDate,
    userStatusId
)
VALUES
(
    1,
    'Administrador',
    'admin',
    0x1234,
    'admin@test.com',
    '88888888',
    1,
    1,
    '2000-01-01',
    1,
    GETDATE(),
    1
);

SET IDENTITY_INSERT SQM_SECURITY.Tbl_Users OFF;

SELECT *
FROM SQM_SECURITY.Tbl_Users;

INSERT INTO SQM_CATALOGS.Tbl_Categories
(
    categoryName,
    categoryDescription,
    categoryCreatorId,
    categoryCreationDate,
    categoryStatusId
)
VALUES
(
    'Electronica',
    'Productos Electronicos',
    1,
    GETDATE(),
    1
);

INSERT INTO SQM_CATALOGS.Tbl_SubCategories
(
    subCategoryName,
    subCategoryDescription,
    subCategoryCreatorId,
    subCategoryCreationDate,
    subCategoryStatusId
)
VALUES
(
    'Celulares',
    'Telefonos Inteligentes',
    1,
    GETDATE(),
    1
);

INSERT INTO SQM_CATALOGS.Tbl_Segments
(
    segmentName,
    segmentDescription,
    segmentCreatorId,
    segmentCreationDate,
    segmentStatusId
)
VALUES
(
    'Premium',
    'Gama Alta',
    1,
    GETDATE(),
    1
);

INSERT INTO SQM_CATALOGS.Tbl_ProductIdentificators
(
    productIdentificatorCategoryId,
    productIdentificatorSubCategoryId,
    productIdentificatorSegmentId,
    productIdentificatorCreatorId,
    productIdentificatorCreationDate,
    productIdentificatorStatusId
)
VALUES
(
    4, -- categoryId real
    1, -- subCategoryId
    1, -- segmentId
    1,
    GETDATE(),
    1
);;

INSERT INTO SQM_CATALOGS.Tbl_Providers
(
    providerName,
    providerDescription,
    providerCreatorId,
    providerCreationDate,
    providerStatusId
)
VALUES
(
    'Samsung Supplier',
    'Proveedor Oficial Samsung',
    1,
    GETDATE(),
    1
);

INSERT INTO SQM_CATALOGS.Tbl_Marks
(
    markName,
    markDescription,
    markCreatorId,
    markCreationDate,
    markStatusId
)
VALUES
(
    'Samsung',
    'Marca Samsung',
    1,
    GETDATE(),
    1
);

INSERT INTO SQM_CATALOGS.Tbl_MarkByProviders
(
    markByProviderMarkId,
    markByProviderProviderId,
    markByProviderCreatorId,
    markByProviderCreationDate,
    markByProviderStatusId
)
VALUES
(
    1,
    1,
    1,
    GETDATE(),
    1
);

INSERT INTO SQM_CATALOGS.Tbl_Currencies
(
    currencyName,
    currencyISO,
    currencyCode,
    currencyDescription,
    currencyCreatorId,
    currencyCreationDate,
    currencyStatusId
)
VALUES
(
    'Dolar',
    'USD',
    840,
    'Dolar Americano',
    1,
    GETDATE(),
    1
);

INSERT INTO SQM_GENERAL.Tbl_Products
(
    productName,
    productDescription,
    productProductIdentificatorId,
    productMarkByProviderId,
    productCreatorId,
    productCreationDate,
    productStatusId
)
VALUES
(
    'Samsung Galaxy S25',
    'Telefono Samsung Galaxy S25',
    2, -- ESTE ES EL ID CORRECTO
    1,
    1,
    GETDATE(),
    1
);

INSERT INTO SQM_GENERAL.Tbl_ProductVariables
(
    productVariableProductId,
    productVariableValue,
    productVariablePrice,
    productVariableCurrencyId,
    productVariableCreatorId,
    productVariableCreationDate,
    productVariableStatusId
)
VALUES
(
    3,              -- productId REAL
    '256GB Negro',
    1200.00,
    1,              -- currencyId
    1,
    GETDATE(),
    1
);

INSERT INTO SQM_GENERAL.Tbl_Stocks
(
    stockProductVariableId,
    stockQuantity,
    stockFactoryDate,
    stockExpirationDate,
    stockCreatorId,
    stockCreationDate,
    stockStatusId
)
VALUES
(
    (SELECT MAX(productVariableId)
     FROM SQM_GENERAL.Tbl_ProductVariables),
    100,
    '2026-01-01',
    '2030-01-01',
    1,
    GETDATE(),
    1
);
DECLARE @Code INT,
        @Message VARCHAR(500);

EXEC SP_SearchProducts
    @i_FilterText = 'Samsung',
    @o_ResultCode = @Code OUTPUT,
    @o_ResultMessage = @Message OUTPUT;

SELECT @Code AS Codigo,
       @Message AS Mensaje;

SELECT *
FROM SQM_GENERAL.VW_GENERAL_PRODUCTS;
SELECT *
FROM SQM_GENERAL.Tbl_Stocks;
SELECT *
FROM SQM_GENERAL.Tbl_Products;
SELECT *
FROM SQM_CATALOGS.Tbl_Currencies;

SELECT * FROM SQM_CATALOGS.Tbl_ProductIdentificators;

SELECT * FROM SQM_CATALOGS.Tbl_MarkByProviders;

SELECT * FROM SQM_CATALOGS.Tbl_Marks;

SELECT * FROM SQM_CATALOGS.Tbl_Providers;

SELECT categoryId, categoryName
FROM SQM_CATALOGS.Tbl_Categories;

SELECT subCategoryId, subCategoryName
FROM SQM_CATALOGS.Tbl_SubCategories;

SELECT segmentId, segmentName
FROM SQM_CATALOGS.Tbl_Segments;




/*=========================================================
A, B y C - REGLAS DEL CHATBOT
=========================================================*/



CREATE TABLE ReglasChatbot (
    ReglaID INT PRIMARY KEY IDENTITY(1,1),
    NombreRegla VARCHAR(100) NOT NULL,
    AccionDinamica BIT NOT NULL,     -- 'TEXTO_ESTATICO' o 'ACCION_DINAMICA'
    AccionPython VARCHAR(100) NULL,         -- Nombre de la funci�n en Python (si es din�mica)
    Activo BIT                    -- Para activar/desactivar reglas f�cilmente
);

-- 2. CREACI�N DE LA TABLA SECUNDARIA: PALABRAS CLAVE (TRIGGERS)
-- Aqu� guardamos las palabras que el usuario podr�a escribir para activar la regla.
CREATE TABLE PalabrasClaveRegla (
    PalabraClaveID INT PRIMARY KEY IDENTITY(1,1),
    ReglaID INT NOT NULL REFERENCES ReglasChatbot(ReglaID),
    PalabraClave VARCHAR(100) NOT NULL,
	Activo BIT
);

-- =====================================================================
-- 1. TABLA: VARIACIONES DE RESPUESTAS (PLANTILLAS DE SALIDA)
-- Modificamos el enfoque anterior para que una regla tenga MUCHAS opciones de respuesta.
-- =====================================================================

-- Primero, una buena pr�ctica: si ya creaste la tabla 'ReglasChatbot' con la columna 'RespuestaTexto',
-- la eliminamos de ah� porque ahora vivir� de forma m�s organizada en esta nueva tabla.
CREATE TABLE PlantillasRespuesta (
    PlantillaID INT IDENTITY(1,1) PRIMARY KEY,
    ReglaID INT NOT NULL REFERENCES ReglasChatbot(ReglaID),
    TextoRespuesta NVARCHAR(MAX) NOT NULL, -- La frase exacta que dir� el bot
    Activo BIT
);


-- =====================================================================
-- 2. TABLA: HISTORIAL DE CONVERSACIONES (LOGS DE ENTRADA Y SALIDA)
-- Aqu� se almacena la interacci�n real del e-commerce. Todo lo que entra y sale.
-- =====================================================================
CREATE TABLE HistorialConversaciones
(
	ConversacionID BIGINT IDENTITY(1,1) PRIMARY KEY,
	UsuarioID VARCHAR(100) NOT NULL,
	FechaInicio DATETIME NOT NULL,
	FechaFin DATETIME NULL,
	Activo BIT
)

CREATE TABLE HistorialMensajes (
    MensajeID BIGINT IDENTITY(1,1) PRIMARY KEY,
	ConversacionID BIGINT REFERENCES HistorialConversaciones (ConversacionID) NOT NULL,
    ChatBot BIT NOT NULL,           -- 'USUARIO' o 'SISTEMA'
    Texto VARCHAR(1000) NOT NULL,             -- El mensaje de texto enviado o recibido
    FechaHora DATETIME NOT NULL,     -- Momento exacto de la interacci�n
    ReglaActivadaID INT REFERENCES ReglasChatbot(ReglaID),               -- Qu� regla del sistema experto respondi� (si fue el SISTEMA)       
);

INSERT INTO ReglasChatbot
(
    NombreRegla,
    AccionDinamica,
    AccionPython,
    Activo
)
VALUES
('Saludo Inicial',1,'cargar_saludos_db',1),

('Buscar Producto',1,'buscar_producto_en_db',1),

('No Entendido',0,NULL,1);

GO

/*=========================================================
D - PALABRAS CLAVE PARA SALUDO
=========================================================*/

INSERT INTO PalabrasClaveRegla
(
    ReglaID,
    PalabraClave,
    Activo
)
VALUES
(1,'hola',1),
(1,'buenos dias',1),
(1,'buenas tardes',1),
(1,'buenas noches',1),
(1,'saludos',1),
(1,'hello',1);

GO

/*=========================================================
E - PALABRAS CLAVE PARA BUSQUEDA DE PRODUCTOS
=========================================================*/

INSERT INTO PalabrasClaveRegla
(
    ReglaID,
    PalabraClave,
    Activo
)
VALUES
(2,'buscar',1),
(2,'producto',1),
(2,'productos',1),
(2,'precio',1),
(2,'stock',1),
(2,'tienen',1),
(2,'samsung',1),
(2,'iphone',1),
(2,'celular',1),
(2,'telefono',1),
(2,'laptop',1),
(2,'computadora',1);

GO

/*=========================================================
F - RESPUESTAS PARA SALUDO INICIAL
=========================================================*/

INSERT INTO PlantillasRespuesta
(
    ReglaID,
    TextoRespuesta,
    Activo
)
VALUES
(
    1,
    '¡Hola! Bienvenido a nuestra tienda. ¿En qué puedo ayudarte hoy?',
    1
),
(
    1,
    '¡Qué gusto tenerte de vuelta! ¿Buscas algún producto de nuestro catálogo?',
    1
),
(
    1,
    'Hola, soy tu asistente virtual de compras. ¿Qué producto deseas buscar?',
    1
);

GO

/*=========================================================
G - RESPUESTAS PARA BUSQUEDA DE PRODUCTOS
=========================================================*/

INSERT INTO PlantillasRespuesta
(
    ReglaID,
    TextoRespuesta,
    Activo
)
VALUES
(
    2,
    'Estoy buscando los productos que coinciden con tu solicitud.',
    1
),
(
    2,
    'He encontrado algunas opciones relacionadas con tu búsqueda.',
    1
),
(
    2,
    'Permíteme consultar nuestro catálogo para mostrarte los productos disponibles.',
    1
);

GO

/*=========================================================
H - RESPUESTAS PARA NO ENTENDIDO
=========================================================*/

INSERT INTO PlantillasRespuesta
(
    ReglaID,
    TextoRespuesta,
    Activo
)
VALUES
(
    3,
    'Lo siento, no logré comprender tu solicitud. ¿Podrías reformularla?',
    1
),
(
    3,
    'No entendí tu petición. Intenta escribirla de otra manera.',
    1
),
(
    3,
    'No encontré una regla para procesar tu mensaje. ¿Puedes ser más específico?',
    1
);

GO

/*=========================================================
VERIFICACION
=========================================================*/

SELECT *
FROM ReglasChatbot;

SELECT *
FROM PalabrasClaveRegla;

SELECT *
FROM PlantillasRespuesta;

SELECT
    r.ReglaID,
    r.NombreRegla,
    p.PalabraClave,
    r.AccionDinamica,
    r.AccionPython
FROM ReglasChatbot r
INNER JOIN PalabrasClaveRegla p
    ON r.ReglaID = p.ReglaID
WHERE r.Activo = 1
  AND p.Activo = 1

  SELECT * FROM ReglasChatbot
SELECT * FROM PalabrasClaveRegla