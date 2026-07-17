<%@page import="com.operations.commtransactions.saliktrafficfineentry.ClsSaliktrafficDAO" %>
<% ClsSaliktrafficDAO cstd = new ClsSaliktrafficDAO();%> 

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 <script type="text/javascript">

   var mtufleet='<%=cstd.trafficsearchfleet(session)%>';
  
        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'reg_no', type: 'String'  },
     						{name : 'fleet_no', type: 'String'  },
     						{name : 'pltid', type: 'String'  },
     						{name : 'flname', type: 'String'  },
     						{name : 'authid', type: 'String'  },
						{name : 'tcno', type: 'String'  }
     				                        	
                          	],
             
                          	localdata: mtufleet,
                
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
            $("#trafficflsearch").jqxGrid(
            {
                width: '99.9%',
                height: 330,
                source: dataAdapter,
            
                filterable: true,
                showfilterrow: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
              
                //Add row method
	
                columns: [

					{ text: 'FLEET', datafield: 'fleet_no', width: '17%' },
					{ text: 'NAME', datafield: 'flname', width: '65%'  },
					{ text: 'Reg NO', datafield: 'reg_no', width: '18%' },
					{ text: 'TCNO', datafield: 'tcno', width: '15%',hidden:true},
			
				/* 	{ text: 'COLOR', datafield: 'color', width: '17%', cellsalign: 'center', align:'center' },
					{ text: 'GROUP', datafield: 'gname', width: '18%', cellsalign: 'center', align:'center' },
					{ text: 'Location', datafield: 'a_loc', width: '15%',hidden:true},
					{ text: 'GID', datafield: 'gid', width: '15%',hidden:true},
					{ text: 'KM', datafield: 'kmin', width: '15%',hidden:true},
					 { text: 'FUEL', datafield: 'fin', width: '15%',hidden:true}, */
					
					]
            });
            
            $('#trafficflsearch').on('rowdoubleclick', function (event) 
            		{ 
            
            	  var rowBoundIndex = event.args.rowindex;
            	  var rowindex3 =$('#rowindex').val();
                  $('#traficgrid').jqxGrid('setcellvalue', rowindex3, "fleetno" ,$('#trafficflsearch').jqxGrid('getcellvalue', rowBoundIndex, "fleet_no"));
                  $('#traficgrid').jqxGrid('setcellvalue', rowindex3, "regno" ,$('#trafficflsearch').jqxGrid('getcellvalue', rowBoundIndex, "reg_no"));
                  $('#traficgrid').jqxGrid('setcellvalue', rowindex3, "source" ,$('#trafficflsearch').jqxGrid('getcellvalue', rowBoundIndex, "authid"));
                  $('#traficgrid').jqxGrid('setcellvalue', rowindex3, "pltid" ,$('#trafficflsearch').jqxGrid('getcellvalue', rowBoundIndex, "pltid"));
		 $('#traficgrid').jqxGrid('setcellvalue', rowindex3, "tcno" ,$('#trafficflsearch').jqxGrid('getcellvalue', rowBoundIndex, "tcno"));
                  var rows = $('#traficgrid').jqxGrid('getrows');
                  var rowlength= rows.length;
                  if(rowindex3==rowlength-1)
                  {
            
               	 $("#traficgrid").jqxGrid('addrow', null, {});      
                
        	      }  
            		  
                $('#tafficfleetsearchwindow').jqxWindow('close');
              
            	
            		 }); 
      
        });
    </script>
    <div id="trafficflsearch"></div>