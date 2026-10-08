CLASS zcl_boq_sales_rpt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_amdp_marker_hdb.
  CLASS-METHODS get_data FOR TABLE FUNCTION zsd_boq_function.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BOQ_SALES_RPT IMPLEMENTATION.


    METHOD get_data
  BY DATABASE FUNCTION
  FOR HDB LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY USING zsd_sales_datewise zsd_sales_sowise zsd_sales_rv zsd_bom_rv.
*Final Table Declaration for Output.
  DECLARE FINAL TABLE
    ( mandt            NVARCHAR( 3 ),
      SalesOrderNumber NVARCHAR( 10 ),
      SalesOrderItem   NUMERIC( 6 ),
*      ScheduleLine     NUMERIC( 4 ),       //No Need
      ItemLevel01      INTEGER,
      ItemLevel02      INTEGER,
      ItemLevel03      INTEGER,
      SalesOrderStatus NVARCHAR( 40 ),
      CustomerName     NVARCHAR( 80 ),
      SalesDate        NVARCHAR( 8 ),
      DeliveryDate     NVARCHAR( 8 ),
*      ScheduleCategory NVARCHAR( 2 ),      //No Need
      FGNumber         NVARCHAR( 40 ),
      FGName           NVARCHAR( 60 ),
      FGBaseQty        DECIMAL,
      FGQty            DECIMAL,
*      ScheduleQuantity DECIMAL,            //No Need
      SFGVariant       NVARCHAR( 2 ),
      SFGNumber        NVARCHAR( 40 ),
      SFGName          NVARCHAR( 60 ),
      SFGBaseQty       DECIMAL,
      SFGQty           DECIMAL,
      KITBOQVariant    NVARCHAR( 2 ),
      KITBOQ           NVARCHAR( 40 ),
      KITBOQName       NVARCHAR( 60 ),
      KITBOQQty        DECIMAL,
      SalesHead        NVARCHAR( 80 ),
      SalesPerson      NVARCHAR( 80 ),
      BranchName       NVARCHAR( 40 ),
      BillStatus       NVARCHAR( 40 ) );
*Declaring Indexes for All Sales Order based on User Input with initialization of Final Table Index
      DECLARE AllSalesOrder_Index int := 1;
      DECLARE AllSalesOrder_Records int;
      DECLARE FINAL_Index int := 1;
*Fetching All Sales Order based on User Input
      IF SalesONumber = 'N/A' THEN
        AllSalesOrder = SELECT SalesOrder FROM zsd_sales_datewise (FromDate => :FromDate , ToDate => :ToDate  ) ORDER BY SalesOrder ASC;
      ELSE
        AllSalesOrder = SELECT SalesOrder FROM zsd_sales_sowise (SalesONumber => :SalesONumber ) ORDER BY SalesOrder ASC;
      END if;
*Getting Number of Available Sales Order based on User Input
      AllSalesOrder_Records = record_count( :AllSalesOrder );
*Starting Do While Loop of Sales Order
      IF  AllSalesOrder_Records <> 0 THEN
        WHILE AllSalesOrder_Index  BETWEEN 1 AND AllSalesOrder_Records DO
*Declaring Indexes for Sales Order Details line item wise with current index Sales Order
          DECLARE SalesOrder_Index int := 1;
          DECLARE SalesOrder_Records int;
          DECLARE SalesONumber NVARCHAR( 10 ) := :AllSalesOrder.SalesOrder[ :AllSalesOrder_Index ];
*Fetching Sales Order Details line item wise for current Sales Order
          SalesOrder_Details = SELECT * FROM zsd_sales_rv( SalesONumber => :SalesONumber ) ORDER BY SalesOrderNumber, SalesOrderItem ASC;

          SalesOrder_Records = record_count( :SalesOrder_Details );
*Starting Do While Loop of Sales Order line items(Level 1 Loop Iteration)
          IF SalesOrder_Records <> 0 THEN
            WHILE SalesOrder_Index BETWEEN 1 AND SalesOrder_Records DO
*Declaring Indexes for Semi Furnished Goods Details with Finished Goods & It's Plant
              DECLARE SFG_Index int := 1;
              DECLARE SFG_Records int;
              DECLARE Material NVARCHAR( 40 ) := :SalesOrder_Details.FGNo[ :SalesOrder_Index ];
              DECLARE Plant NVARCHAR( 4 ) := :SalesOrder_Details.Plant[ :SalesOrder_Index ];
              DECLARE ProductType NVARCHAR( 4 ) := :SalesOrder_Details.FGType[ :SalesOrder_Index ];
*Filling Data to Final Table for First Level Item (Finished Goods)
              FINAL_Index = record_count( :Final );
              FINAL_Index = FINAL_Index + 1;

            IF ProductType = 'ROH' THEN
              FINAL.SalesOrderNumber[ :FINAL_Index ] = :SalesOrder_Details.SalesOrderNumber[ SalesOrder_Index ];
              FINAL.SalesOrderItem[ :FINAL_Index ] = :SalesOrder_Details.SalesOrderItem[ SalesOrder_Index ];
              FINAL.SalesOrderStatus[ :FINAL_Index ] = :SalesOrder_Details.SOStatus[ SalesOrder_Index ];
              FINAL.CustomerName[ :FINAL_Index ] = :SalesOrder_Details.CustomerName[ SalesOrder_Index ];
              FINAL.SalesDate[ :FINAL_Index ] = :SalesOrder_Details.SODate[ SalesOrder_Index ];
              FINAL.DeliveryDate[ :FINAL_Index ] = :SalesOrder_Details.DeliveryDate[ SalesOrder_Index ];
              FINAL.FGName[ :FINAL_Index ] = 'Spare';
              FINAL.KITBOQ[ :FINAL_Index ] = :SalesOrder_Details.FGNo[ SalesOrder_Index ];
              FINAL.KITBOQName[ :FINAL_Index ] = :SalesOrder_Details.FGDescription[ SalesOrder_Index ];
              FINAL.KITBOQQty[ :FINAL_Index ] = :SalesOrder_Details.OrderQuantity[ SalesOrder_Index ];
              FINAL.SalesHead[ :FINAL_Index ] = :SalesOrder_Details.SalesHead[ SalesOrder_Index ];
              FINAL.SalesPerson[ :FINAL_Index ] = :SalesOrder_Details.SalesPerson[ SalesOrder_Index ];
              FINAL.BranchName[ :FINAL_Index ] = :SalesOrder_Details.BranchName[ SalesOrder_Index ];
              FINAL.BillStatus[ :FINAL_Index ] = :SalesOrder_Details.BillStatus[ SalesOrder_Index ];
              FINAL.ItemLevel01[ :FINAL_Index ] = :SalesOrder_Index;
            ELSE
              FINAL.SalesOrderNumber[ :FINAL_Index ] = :SalesOrder_Details.SalesOrderNumber[ SalesOrder_Index ];
              FINAL.SalesOrderItem[ :FINAL_Index ] = :SalesOrder_Details.SalesOrderItem[ SalesOrder_Index ];
*              FINAL.ScheduleLine[ :FINAL_Index ] = :SalesOrder_Details.ScheduleLine[ SalesOrder_Index ];
              FINAL.SalesOrderStatus[ :FINAL_Index ] = :SalesOrder_Details.SOStatus[ SalesOrder_Index ];
              FINAL.CustomerName[ :FINAL_Index ] = :SalesOrder_Details.CustomerName[ SalesOrder_Index ];
              FINAL.SalesDate[ :FINAL_Index ] = :SalesOrder_Details.SODate[ SalesOrder_Index ];
              FINAL.DeliveryDate[ :FINAL_Index ] = :SalesOrder_Details.DeliveryDate[ SalesOrder_Index ];
*              FINAL.ScheduleCategory[ :FINAL_Index ] = :SalesOrder_Details.ScheduleCategory[ SalesOrder_Index ];
              FINAL.FGNumber[ :FINAL_Index ] = :SalesOrder_Details.FGNo[ SalesOrder_Index ];
              FINAL.FGName[ :FINAL_Index ] = :SalesOrder_Details.FGDescription[ SalesOrder_Index ];
              FINAL.FGQty[ :FINAL_Index ] = :SalesOrder_Details.OrderQuantity[ SalesOrder_Index ];
*              FINAL.ScheduleQuantity[ :FINAL_Index ] = :SalesOrder_Details.OpenQuantity[ SalesOrder_Index ];
              FINAL.SalesHead[ :FINAL_Index ] = :SalesOrder_Details.SalesHead[ SalesOrder_Index ];
              FINAL.SalesPerson[ :FINAL_Index ] = :SalesOrder_Details.SalesPerson[ SalesOrder_Index ];
              FINAL.BranchName[ :FINAL_Index ] = :SalesOrder_Details.BranchName[ SalesOrder_Index ];
              FINAL.BillStatus[ :FINAL_Index ] = :SalesOrder_Details.BillStatus[ SalesOrder_Index ];
              FINAL.ItemLevel01[ :FINAL_Index ] = :SalesOrder_Index;
*Fetching All SFG Materials based on FG Material Details
              SFG = SELECT * FROM zsd_bom_rv( Material => :Material, Plant => :Plant ) ORDER BY MaterialNum, Variant, MaterialComponent ASC;

              FINAL.FGBaseQty[ :FINAL_Index ] = :SFG.MaterialQty[ 1 ];

              SFG_Records = record_count( :SFG );
*Starting Do While Loop of SFG Material (Level 2 Loop Iteration)
              IF SFG_Records <> 0 THEN
                WHILE SFG_Index BETWEEN 1 AND SFG_Records DO
*Declaring Indexes for Raw Material Details with SFG Material
                  DECLARE KIT_Index int := 1;
                  DECLARE KIT_Records int;
                  DECLARE Material1 NVARCHAR( 40 ) := :SFG.MaterialComponent[ :SFG_Index ];

                  FINAL_Index = FINAL_Index + 1;

                  FINAL.SalesOrderNumber[ :FINAL_Index ] = :SalesOrder_Details.SalesOrderNumber[ SalesOrder_Index ];
                  FINAL.SalesOrderItem[ :FINAL_Index ] = :SalesOrder_Details.SalesOrderItem[ SalesOrder_Index ];
*                  FINAL.ScheduleLine[ :FINAL_Index ] = :SalesOrder_Details.ScheduleLine[ SalesOrder_Index ];
                  FINAL.SalesOrderStatus[ :FINAL_Index ] = :SalesOrder_Details.SOStatus[ SalesOrder_Index ];
                  FINAL.CustomerName[ :FINAL_Index ] = :SalesOrder_Details.CustomerName[ SalesOrder_Index ];
                  FINAL.SalesDate[ :FINAL_Index ] = :SalesOrder_Details.SODate[ SalesOrder_Index ];
                  FINAL.DeliveryDate[ :FINAL_Index ] = :SalesOrder_Details.DeliveryDate[ SalesOrder_Index ];
*                  FINAL.ScheduleCategory[ :FINAL_Index ] = :SalesOrder_Details.ScheduleCategory[ SalesOrder_Index ];
                  FINAL.SalesHead[ :FINAL_Index ] = :SalesOrder_Details.SalesHead[ SalesOrder_Index ];
                  FINAL.SalesPerson[ :FINAL_Index ] = :SalesOrder_Details.SalesPerson[ SalesOrder_Index ];
                  FINAL.BranchName[ :FINAL_Index ] = :SalesOrder_Details.BranchName[ SalesOrder_Index ];
                  FINAL.BillStatus[ :FINAL_Index ] = :SalesOrder_Details.BillStatus[ SalesOrder_Index ];
                  FINAL.FGNumber[ :FINAL_Index ] = :SalesOrder_Details.FGNo[ SalesOrder_Index ];
                  FINAL.FGName[ :FINAL_Index ] = :SalesOrder_Details.FGDescription[ SalesOrder_Index ];
                  FINAL.SFGVariant[ :FINAL_Index ] = :SFG.Variant[ SFG_Index ];
                  FINAL.SFGNumber[ :FINAL_Index ] = :SFG.MaterialComponent[ SFG_Index ];
                  FINAL.SFGName[ :FINAL_Index ] = :SFG.ComponentDescription[ SFG_Index ];
                  FINAL.SFGQty[ :FINAL_Index ] = :SalesOrder_Details.OrderQuantity[ SalesOrder_Index ] / :SFG.MaterialQty[ SFG_Index ] * :SFG.ComponentQty[ SFG_Index ];
                  FINAL.ItemLevel01[ :FINAL_Index ] = :SalesOrder_Index;
                  FINAL.ItemLevel02[ :FINAL_Index ] = :SFG_Index;
*Fetching All Raw Materials based on SFG Material Details
                  KIT = SELECT * FROM zsd_bom_rv( Material => :Material1, Plant => :Plant ) ORDER BY MaterialNum, Variant, MaterialComponent ASC;

                  FINAL.SFGBaseQty[ :FINAL_Index ] = :KIT.MaterialQty[ 1 ];

                  KIT_Records = record_count( :KIT );
*Starting Do While Loop of Raw Material (Level 3 Loop Iteration)
                  IF KIT_Records <> 0 THEN
                    WHILE KIT_Index BETWEEN 1 AND KIT_Records DO

                      FINAL_Index = FINAL_Index + 1;

                      FINAL.SalesOrderNumber[ :FINAL_Index ] = :SalesOrder_Details.SalesOrderNumber[ SalesOrder_Index ];
                      FINAL.SalesOrderItem[ :FINAL_Index ] = :SalesOrder_Details.SalesOrderItem[ SalesOrder_Index ];
*                      FINAL.ScheduleLine[ :FINAL_Index ] = :SalesOrder_Details.ScheduleLine[ SalesOrder_Index ];
                      FINAL.SalesOrderStatus[ :FINAL_Index ] = :SalesOrder_Details.SOStatus[ SalesOrder_Index ];
                      FINAL.CustomerName[ :FINAL_Index ] = :SalesOrder_Details.CustomerName[ SalesOrder_Index ];
                      FINAL.SalesDate[ :FINAL_Index ] = :SalesOrder_Details.SODate[ SalesOrder_Index ];
                      FINAL.DeliveryDate[ :FINAL_Index ] = :SalesOrder_Details.DeliveryDate[ SalesOrder_Index ];
*                      FINAL.ScheduleCategory[ :FINAL_Index ] = :SalesOrder_Details.ScheduleCategory[ SalesOrder_Index ];
                      FINAL.SalesHead[ :FINAL_Index ] = :SalesOrder_Details.SalesHead[ SalesOrder_Index ];
                      FINAL.SalesPerson[ :FINAL_Index ] = :SalesOrder_Details.SalesPerson[ SalesOrder_Index ];
                      FINAL.BranchName[ :FINAL_Index ] = :SalesOrder_Details.BranchName[ SalesOrder_Index ];
                      FINAL.BillStatus[ :FINAL_Index ] = :SalesOrder_Details.BillStatus[ SalesOrder_Index ];
                      FINAL.FGNumber[ :FINAL_Index ] = :SalesOrder_Details.FGNo[ SalesOrder_Index ];
                      FINAL.FGName[ :FINAL_Index ] = :SalesOrder_Details.FGDescription[ SalesOrder_Index ];
                      FINAL.KITBOQVariant[ :FINAL_Index ] = :KIT.Variant[ KIT_Index ];
                      FINAL.KITBOQ[ :FINAL_Index ] = :KIT.MaterialComponent[ KIT_Index ];
                      FINAL.KITBOQName[ :FINAL_Index ] = :KIT.ComponentDescription[ KIT_Index ];
                      FINAL.KITBOQQty[ :FINAL_Index ] = ( :SalesOrder_Details.OrderQuantity[ SalesOrder_Index ] / :SFG.MaterialQty[ SFG_Index ] * :SFG.ComponentQty[ SFG_Index ] ) / :KIT.MaterialQty[ KIT_Index ] * :KIT.ComponentQty[ KIT_Index ];
                      FINAL.ItemLevel01[ :FINAL_Index ] = :SalesOrder_Index;
                      FINAL.ItemLevel02[ :FINAL_Index ] = :SFG_Index;
                      FINAL.ItemLevel03[ :FINAL_Index ] = :KIT_Index;
*Adding 1 for next line iteration of Raw Material
                      KIT_Index = KIT_Index + 1;
                    END WHILE ;
                  END IF ;
*Adding 1 for next line iteration of SFG Material
                 SFG_Index = SFG_Index + 1;
                END WHILE ;
              END IF ;
            END IF ;
*Adding 1 for next line iteration of Sales Order Line Item
              SalesOrder_Index = SalesOrder_Index + 1;
            END WHILE ;
          END IF ;
*Adding 1 for next line iteration of Sales Order
          AllSalesOrder_Index = AllSalesOrder_Index + 1;
        END WHILE ;
      END IF ;

  RETURN
*Returning Report data from Final Table to Display
    SELECT  session_context('CLIENT') AS mandt,
            SalesOrderNumber,
            SalesOrderItem,
*            ScheduleLine,
            ItemLevel01,
            ItemLevel02,
            ItemLevel03,
            SalesOrderStatus,
            CustomerName,
            SalesDate,
            DeliveryDate,
*            ScheduleCategory,
            FGNumber,
            FGName,
            FGBaseQty,
            FGQty,
*            ScheduleQuantity,
            SFGVariant,
            SFGNumber,
            SFGName,
            SFGBaseQty,
            SFGQty,
            KITBOQVariant,
            KITBOQ,
            KITBOQName,
            KITBOQQty,
            SalesHead,
            SalesPerson,
            BranchName,
            BillStatus
      FROM :FINAL
      ORDER BY SalesOrderNumber, SalesOrderItem, ItemLevel01, ItemLevel02, ItemLevel03;
*Sorting Data Based on Key Fields for Better Reporting

ENDMETHOD.
ENDCLASS.
