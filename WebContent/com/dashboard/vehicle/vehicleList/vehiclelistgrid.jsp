<%@ page import="com.dashboard.vehicle.ClsvehicleDAO" %>
<%ClsvehicleDAO cvd=new ClsvehicleDAO(); %>

 <%
 
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");
 %>

 <script type="text/javascript">

 
 var chk='<%=chk%>';
 
 var vehlistdata;
 if(chk=="load")
	{
	 
	 
 vehlistdata='<%=cvd.vehicleListSearch(chk)%>'; 

 vehicleexceldata='<%=cvd.vehicleexcelListSearch(chk)%>'; 
	}
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
                            {name : 'pno', type: 'string'  },
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
 						
 						{name : 'age', type: 'string'  },
 						{name : 'salik_tag', type: 'string'  },
 							
 						{name : 'currentkm', type: 'string'  },
 						
 						{name : 'st_desc', type: 'string'  },
 						
 						
 							
     						
     						
                          	],
                          	localdata: vehlistdata,
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
            $("#vehiclelist").jqxGrid(
            {
            	 width: '100%',
 				height: 500,
                 source: dataAdapter,
                 groupable: true,
                // filterable: true,
                 //showfilterrow: true,
                  sortable:true,
                 selectionmode: 'singlecell',
                 groups: ['vgrpname','brdname','vmodname','yom'],
            
            
     					
                columns: [
 
                          
                          
				/* 	{ text: 'Doc No', datafield: 'doc_no', width: '3%' },
					{ text: 'Date', datafield: 'date', width: '5%',cellsformat:'dd.MM.yyyy' }, */
					
					{ text: 'SL#', sortable: false, filterable: false, editable: false, 
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },
				
					
					     { text: 'Fleet NO', groupable: false,datafield: 'fleet_no', width: '6%' },    
					     { text: 'Authority ',groupable: false, datafield: 'authname', width: '10%' }, 
					     { text: 'Reg_NO',groupable: false, datafield: 'reg_no', width: '6%' }, 
					     { text: 'Plate Code ',groupable: false, datafield: 'pltname', width: '8%' }, 
					     { text: 'Fleet Name', groupable: false,datafield: 'flname', width: '13%' },
						 { text: 'Tariff Group',groupable: true, datafield: 'vgrpname', width: '10%' },
						 { text: 'Brand', groupable: true,datafield: 'brdname', width: '10%' },
						 { text: 'Model', groupable: true,datafield: 'vmodname', width: '10%' },
						 { text: 'Engine No', groupable: true,datafield: 'eng_no', width: '10%' },
						 { text: 'Chassis No', groupable: true,datafield: 'ch_no', width: '10%' },
						 { text: 'Trancode',groupable: false, datafield: 'st_desc', width: '12%' } ,
						 { text: 'YOM', groupable: true,datafield: 'yom', width: '5%' }, 
						 { text: 'Color', groupable: false,datafield: 'clrname', width: '7%' },
						 { text: 'Current KM', groupable: false,datafield: 'currentkm', width: '7%' },
						 { text: 'Reg_Date',groupable: false, datafield: 'reg_date', width: '7%',cellsformat:'dd.MM.yyyy' },
						 { text: 'Ins_Exp', groupable: false,datafield: 'ins_exp', width: '7%',cellsformat:'dd.MM.yyyy' },
						 { text: 'Purchase Cost',groupable: false, datafield: 'prch_cost', width: '6%'  ,cellsalign: 'right', align:'right'},
						 { text: 'Additional Cost',groupable: false, datafield: 'add1', width: '6%'  ,cellsalign: 'right', align:'right'},
						 { text: 'Total cost',groupable: false, datafield: 'tval', width: '6%'  ,cellsalign: 'right', align:'right'},
						 { text: 'Depreciation %',groupable: false, datafield: 'depr', width: '7%',cellsalign: 'right', align:'right' },
						 { text: 'Age(months)',groupable: false, datafield: 'age', width: '6%' },
						 { text: 'Salik Tag',groupable: false, datafield: 'salik_tag', width: '8%' },
						 { text: 'Traffic Tcno',groupable: false, datafield: 'tcno', width: '8%' }
						 
						 /* { text: 'Salik Tag',groupable: false, datafield: 'salik_tag', width: '8%', hidden:true } */
						 
					
		
					
							
					
					],
					 groupsrenderer: function (defaultText, group, state, params) {
							return false;
						}
            });
    
            $("#overlay, #PleaseWait").hide();
				           
        
                  }); 
				       
                       
    </script>
    <div id="vehiclelist"></div>