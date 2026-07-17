<%@ page import="com.dashboard.vehicle.ClsvehicleDAO" %>
<%ClsvehicleDAO cvd=new ClsvehicleDAO(); %>

 <script type="text/javascript">
 

 var vehdetdata='<%=cvd.vehicleDetailsSearch()%>'; 
        $(document).ready(function () { 
        	
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                            
                             
                          
                             
                            //1
     						{name : 'doc_no', type: 'String'  },
     						{name : 'date', type: 'date'  },
     						 {name : 'reg_no', type: 'String'  }, 
     						{name : 'fleet_no', type: 'String'  },
     						{name : 'flname', type: 'String'  },
     						 {name : 'prch_inv', type: 'String'  }, 
      						{name : 'prch_dte', type: 'date'  },
     						{name : 'prch_cost', type: 'String'  },
     						{name : 'inst_amt', type: 'String'  },
     						
     						{name : 'int_amt', type: 'String'},
     						{name : 'dn_pay', type: 'String'  },
     						{name : 'ins_comp', type: 'String'  },
     						 //2
                            {name : 'pno', type: 'String'  },
    						{name : 'ins_amt', type: 'String'  },
    						 {name : 'prmym_perc', type: 'String'  }, 
    						{name : 'prmym', type: 'String'  },
    						 {name : 'ins_exp', type: 'date'  }, 
     						{name : 'rel_date', type: 'date'  },
    						{name : 'reg_exp', type: 'date'  },
    						{name : 'depr', type: 'String'  },
    						
    						{name : 'eng_no', type: 'String'},
    						{name : 'ch_no', type: 'String'  },
    						{name : 'a_loc', type: 'String'  },
    						{name : 'tval', type: 'String'  },
     						
     						 //3
                            
                          	{name : 'status', type: 'String'  },
                          	{name : 'srvc_km', type: 'String'  },
                          
                          	{name : 'srvc_dte', type: 'String'  },
  						{name : 'lst_srv', type: 'String'  },
  						 {name : 'war', type: 'date'  }, 
  						{name : 'war_km', type: 'String'  },
  						 {name : 'cur_km', type: 'String'  }, 
   						{name : 'itype', type: 'String'  },
  						{name : 'add1', type: 'String'  },
  						{name : 'c_fuel', type: 'String'  },
  						
  						{name : 'tran_code', type: 'String'},
  						{name : 'yom', type: 'String'  },
  						{name : 'reg_date', type: 'date'  },
  						
  					  //4
                        {name : 'lpo', type: 'String'  },
 						{name : 'salik_tag', type: 'String'  },
 						 {name : 'no_inst', type: 'String'  }, 
 						{name : 'fstatus', type: 'String'  },
 						 {name : 'a_br', type: 'String'  }, 
  						{name : 'war_prd', type: 'String'  },
 						{name : 'curr_value', type: 'String'  },
 						{name : 'category', type: 'String'  },
 						
 						{name : 'renttype', type: 'String'},
 						{name : 'dtype', type: 'String'  },
 						{name : 'comp_id', type: 'String'  },
 						
 						{name : 'tcno', type: 'String'  },
 						{name : 'branded', type: 'String'  },
                        
 						 //5
                        {name : 'finname', type: 'String'  },
 						{name : 'authname', type: 'String'  },
 						 {name : 'pltname', type: 'String'  }, 
 						{name : 'vgrpname', type: 'String'  },
 						 {name : 'brdname', type: 'String'  }, 
  						{name : 'vmodname', type: 'String'  },
 						{name : 'dlrname', type: 'String'  },
 						{name : 'brhname', type: 'String'  },
 						
 						{name : 'costname', type: 'String'},
 						{name : 'clrname', type: 'String'  },
 						{name : 'warend', type: 'date'  },
 						
 						{name : 'statu', type: 'String'  },
 						{name : 'fueltype', type: 'String'  },
 						
                               {name : 'tcap', type: 'String'  },
 						
 						{name : 'cost', type: 'String'  },
 						{name : 'accdepr', type: 'String'  },
     						
     						
     						
     						
     						
                          	],
                          	localdata: vehdetdata,
                          //	 url: url1,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#vehicledetails").jqxGrid(
            {
                width: '100%',
                height: 500,
                source: dataAdapter,
                showaggregates:true,
               
                filtermode:'excel',
                filterable: true,
                sortable:true,
                
                selectionmode: 'singlerow',
                pagermode: 'default',
            
            
     					
                columns: [
 
                          
                          
				/* 	{ text: 'Doc No', datafield: 'doc_no', width: '3%' },
					{ text: 'Date', datafield: 'date', width: '5%',cellsformat:'dd.MM.yyyy' }, */
					     { text: 'Fleet NO', datafield: 'fleet_no', width: '5%' },
					     { text: 'Reg.NO', datafield: 'reg_no', width: '5%' }, 
					     { text: 'Salik Tag', datafield: 'salik_tag', width: '5%' },
					     { text: 'TC No.', datafield: 'tcno', width: '5%'},
					     { text: 'Fleet Name', datafield: 'flname', width: '8%' },
						 { text: 'Authority', datafield: 'authname', width: '7%' },
						 { text: 'Plate code', datafield: 'pltname', width: '5%' }, 
						 { text: 'Tariff Group', datafield: 'vgrpname', width: '5%' },
						 { text: 'Brand', datafield: 'brdname', width: '6%' },
						 { text: 'Model', datafield: 'vmodname', width: '6%' },
						 { text: 'YOM', datafield: 'yom', width: '5%' }, 
						 { text: 'Color', datafield: 'clrname', width: '5%' },
						 { text: 'Current KM', datafield: 'cur_km', width: '5%' },
						 { text: 'Fueltype', datafield: 'fueltype', width: '5%' },
						 { text: 'T.Capacity', datafield: 'tcap', width: '5%' },
						 { text: 'Reg_Date', datafield: 'reg_date', width: '5%',cellsformat:'dd.MM.yyyy' },
						 { text: 'Reg_Exp', datafield: 'reg_exp', width: '5%',cellsformat:'dd.MM.yyyy'},
						 { text: 'Ins_Exp', datafield: 'ins_exp', width: '5%',cellsformat:'dd.MM.yyyy' },
						 { text: 'Release Date', datafield: 'rel_date', width: '5%',cellsformat:'dd.MM.yyyy' },
						 { text: 'Puchase Date', datafield: 'prch_dte', width: '5%',cellsformat:'dd.MM.yyyy' },	
						 { text: 'Purch. Order', datafield: 'lpo', width: '5%' },
						 { text: 'Dealer', datafield: 'dlrname', width: '5%' },
						 { text: 'Purchase Invoice', datafield: 'prch_inv', width: '7%' },
						 { text: 'Purchase cost', datafield: 'prch_cost', width: '6%' },
						 { text: 'Additional Cost', datafield: 'add1', width: '7%'},
						 { text: 'Total Cost ', datafield: 'tval', width: '5%' },
						 { text: 'Insurance Company', datafield: 'ins_comp', width: '8%' },
						 { text: 'Insurance Type', datafield: 'itype', width: '7%' },
						 { text: 'Prch_NO', datafield: 'pno', width: '5%' }, 
						 { text: 'Depreciation %', datafield: 'depr', width: '6%' },
						 { text: 'Acc. Depr.', datafield: 'accdepr', width: '5%'},
						 { text: 'Engine No', datafield: 'eng_no', width: '5%' },
						 { text: 'Chasis No', datafield: 'ch_no', width: '5%'},
						 { text: 'Service Interval', datafield: 'srvc_km', width: '7%' },
						 { text: 'Service Date', datafield: 'srvc_dte', width: '5%', cellsformat:'dd.MM.yyyy' }, 
						 { text: 'Last Service KM', datafield: 'lst_srv', width: '6%' },
						 { text: 'Warranty_prd', datafield: 'war_prd', width: '6%' },
						 { text: 'Warranty_Km', datafield: 'war_km', width: '5%' },
						 
					
			/* 		     { text: 'Inst_Amt', datafield: 'inst_amt', width: '5%'},
					     { text: 'Int_Amt', datafield: 'int_amt', width: '5%' },
						 { text: 'Down Pay', datafield: 'dn_pay', width: '5%' },
						 { text: 'Ins_Amt', datafield: 'ins_amt', width: '5%' },
						 { text: 'Premium %', datafield: 'prmym_perc', width: '5%' },
						 { text: 'premium', datafield: 'prmym', width: '5%' },
						 { text: 'Loc', datafield: 'a_loc', width: '5%' },
						 { text: 'Status', datafield: 'status', width: '5%' },
						 { text: 'Warranty', datafield: 'war', width: '5%', cellsformat:'dd.MM.yyyy'},
						 { text: 'Tran_code', datafield: 'tran_code', width: '5%' },
						 { text: 'Fuel', datafield: 'c_fuel', width: '5%'},
						 { text: 'No_Inst', datafield: 'no_inst', width: '5%' }, 
						 { text: 'Fstatus', datafield: 'fstatus', width: '5%' },
						 { text: 'Av_Branch', datafield: 'a_br', width: '5%' },
						 { text: 'Curr_value', datafield: 'curr_value', width: '5%' },
						 { text: 'Category', datafield: 'category', width: '5%' },
						 { text: 'Renttype', datafield: 'renttype', width: '5%'},
						 { text: 'Type', datafield: 'dtype', width: '5%' },
						 { text: 'Company', datafield: 'comp_id', width: '5%' },
						 { text: 'Branded', datafield: 'branded', width: '5%' },
						 { text: 'Fin_Name', datafield: 'finname', width: '5%' },
						 { text: 'Branch', datafield: 'brhname', width: '5%' },
						 { text: 'Costname', datafield: 'costname', width: '5%'},
						 { text: 'Warranty End', datafield: 'warend', width: '5%',cellsformat:'dd.MM.yyyy' },
						 { text: 'Status', datafield: 'statu', width: '5%'},
						 { text: 'Cost', datafield: 'cost', width: '5%'},
									 */
					
							
					
					]
            });
    
           
				           
        
                  }); 
				       
                       
    </script>
    <div id="vehicledetails"></div>