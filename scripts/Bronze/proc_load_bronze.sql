/*
============================================================
Stored procedure: Load Bronze layer (Source --> bronze)
============================================================

Script purpose:
This procedure loads data in to tghe bronze tables from external csv files.
It performs:
  - Truncates the bronze table
  - Uses the bulk insert command to load data from csv files

Parameters:
None.
This stored procedure does not accept any parameters or return any values.

Usage ex:
Exec bronze.load_bronnze;
===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT'==================================================='
		PRINT 'Loading Bronze layer';
		PRINT '=================================================='

	
		PRINT'***************************************************'
		PRINT 'Loading CRM Tables';
		PRINT '***************************************************'

		SET @start_time = GETDATE();
		PRINT '>>TRUNCATING THE TABLE : bronze.crm_cust_info' 
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>>INSERTING INTO THE TABLE : bronze.crm_cust_info' 
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Admin\Documents\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT'>>-------------------------------------------';


		SET @start_time = GETDATE();
		PRINT '>>TRUNCATING THE TABLE : bronze.crm_prd_info' 
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>>INSERTING INTO THE TABLE : bronze.crm_prd_info' 
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Admin\Documents\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT'>>-------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>TRUNCATING THE TABLE : bronze.crm_sales_details' 
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>>INSERTING INTO THE TABLE : bronze.crm_sales_details' 
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Admin\Documents\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT'>>-------------------------------------------';

		PRINT'***************************************************'
		PRINT 'Loading ERP Tables';
		PRINT '***************************************************'

		SET @start_time = GETDATE();
		PRINT '>>TRUNCATING THE TABLE : bronze.erp_cust_az12' 
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>>INSERTING INTO THE TABLE : bronze.erp_cust_az12' 
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Admin\Documents\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT'>>-------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>TRUNCATING THE TABLE : bronze.erp_loc_a101' 
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>>INSERTING INTO THE TABLE : bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Admin\Documents\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT'>>-------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>TRUNCATING THE TABLE : bronze.erp_px_cat_g1v2' 
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>>INSERTING INTO THE TABLE : bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Admin\Documents\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT'>>-------------------------------------------';

		SET @batch_end_time = GETDATE();
		PRINT '============================================================'
		PRINT 'Loading bronze layer is completed';
		PRINT '- Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time,@batch_end_time) AS NVARCHAR) + 'seconds'
		PRINT '============================================================'
	END TRY
	BEGIN CATCH
		PRINT '==============================================================='
		PRINT 'Error occured during loading bronze layer'
		PRINT 'Error message'+ ERROR_MESSAGE();
		PRINT 'Error message'+ CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error message'+ CAST(ERROR_STATE() AS NVARCHAR);

		PRINT '==============================================================='
	END CATCH
END
