<%@page import="com.operations.vehicleprocurement.vehiclepurchasedirect.ClspurchaseDirectDAO" %>
<%ClspurchaseDirectDAO cpd=new ClspurchaseDirectDAO(); %>

<% String flno = request.getParameter("flno")==null?"0":request.getParameter("flno");
String flnames = request.getParameter("flnames")==null?"0":request.getParameter("flnames");
String regnos = request.getParameter("regnos")==null?"0":request.getParameter("regnos");
String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>


	 

<script type="text/javascript">

var	fleet= '<%=cpd.fleetSearch(session,flno,flnames,regnos,check)%>';

$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                        {name : 'fleet_no', type: 'String'  },
						{name : 'flname', type: 'String'  },
					 
						
		
					  	{name : 'color', type: 'String'  },
						{name : 'clrid', type: 'String'  },
						{name : 'gname', type: 'String'  },
						
					  	{name : 'vgrpid', type: 'String'  },
						{name : 'brand_name', type: 'String'  },
						{name : 'brdid', type: 'String'  },
						
					  	{name : 'model', type: 'String'  },
						{name : 'vmodid', type: 'String'  },
						
 
						
						{name : 'reg_no', type: 'String'  },
						
						{name : 'eng_no', type: 'String'  },
						{name : 'prch_cost', type: 'String'  },
						{name : 'addcost', type: 'String'  },
						{name : 'ch_no', type: 'String'  },
						{name : 'price', type: 'String'  },
						
						//  ch_no prch_cost addcost
						
						],
				    localdata: fleet,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#fleetsearchGrid").jqxGrid(
    {
        width: '100%',
        height: 325,
        source: dataAdapter,
 
        selectionmode: 'singlerow',
        pagermode: 'default',
        
        
        
        
 
        
       
        columns: [

						{ text: 'Fleet', datafield: 'fleet_no', width: '20%' },
						{ text: 'Name', datafield: 'flname', width: '55%'},
						{ text: 'Reg NO', datafield: 'reg_no', width: '25%'},
						{ text: 'vehinfo', datafield: 'vehinfo', width: '25%',hidden:true},
					]
    
    });
    
    
    
    
    
    
    $('#fleetsearchGrid').on('rowdoubleclick', function (event) 
    		{ 
    	


			var rowindex3 =$('#rowindex').val();
            var rowindex2 = event.args.rowindex;
    	
    	
               $('#vehpurchasedirgrid').jqxGrid('setcellvalue', rowindex3, "fleet_no" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', rowindex2, "fleet_no"));

               $('#vehpurchasedirgrid').jqxGrid('setcellvalue', rowindex3, "model" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', rowindex2, "model")); 
               $('#vehpurchasedirgrid').jqxGrid('setcellvalue', rowindex3, "modid" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', rowindex2, "vmodid")); 
               $('#vehpurchasedirgrid').jqxGrid('setcellvalue', rowindex3, "brand" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', rowindex2, "brand_name")); 
               $('#vehpurchasedirgrid').jqxGrid('setcellvalue', rowindex3, "brdid" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', rowindex2, "brdid")); 
               $('#vehpurchasedirgrid').jqxGrid('setcellvalue', rowindex3, "color" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', rowindex2, "color")); 
               $('#vehpurchasedirgrid').jqxGrid('setcellvalue', rowindex3, "clrid" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', rowindex2, "clrid")); 
               $('#vehpurchasedirgrid').jqxGrid('setcellvalue', rowindex3, "prch_cost" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', rowindex2, "prch_cost")); 
               $('#vehpurchasedirgrid').jqxGrid('setcellvalue', rowindex3, "addicost" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', rowindex2, "addcost")); 
                $('#vehpurchasedirgrid').jqxGrid('setcellvalue', rowindex3, "price" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', rowindex2, "price"));  
               $('#vehpurchasedirgrid').jqxGrid('setcellvalue', rowindex3, "chaseno" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', rowindex2, "ch_no")); 
               $('#vehpurchasedirgrid').jqxGrid('setcellvalue', rowindex3, "enginno" ,$('#fleetsearchGrid').jqxGrid('getcellvalue', rowindex2, "eng_no")); 
    		    
               var rows = $('#vehpurchasedirgrid').jqxGrid('getrows');
               var rowlength= rows.length;
              
               if (rowindex3 == rowlength - 1) {
        
                                                                        
                        $("#vehpurchasedirgrid").jqxGrid('addrow', null, {});
                                          
                   
               } 
    		    
    	        $('#fleetwindow').jqxWindow('close');
    		});
    
});

	
	
</script>
<div id="fleetsearchGrid"></div>