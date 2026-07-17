<%@page import="com.dashboard.operations.soldlist.*" %>
 <%ClsSoldListDAO solddao=new ClsSoldListDAO();
 //fleetname='+fleetname+'&regno='+regno+'&color='+color+'&fleet='+fleet+'&fleetdocno='+fleetdocno+'&fleetdate='+fleetdate+'&group='+group+'&id=1');
 String fleetname=request.getParameter("fleetname")==null?"":request.getParameter("fleetname");
 String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
 String color=request.getParameter("color")==null?"":request.getParameter("color");
 String fleet=request.getParameter("fleet")==null?"":request.getParameter("fleet");
 String fleetdocno=request.getParameter("fleetdocno")==null?"":request.getParameter("fleetdocno");
 String fleetdate=request.getParameter("fleetdate")==null?"":request.getParameter("fleetdate");
 String group=request.getParameter("group")==null?"":request.getParameter("group");
 String id=request.getParameter("id")==null?"":request.getParameter("id");
 %>
 <script type="text/javascript">
 
 var fleetdata;
  var id='<%=id%>';
  if(id=="1"){ 
	  fleetdata='<%=solddao.getFleet(fleetname,regno,color,fleet,fleetdocno,fleetdate,group,id)%>';
  }
  else{
	  
  }
        $(document).ready(function () { 
        
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'doc_no', type: 'number'  }, 
     						{name : 'fleet_no', type: 'number'  },
     						{name : 'reg_no', type: 'number'  },
     						{name : 'color', type: 'string'  },
     						{name : 'flname', type: 'string'  },
     						{name : 'date', type: 'date' },
     						{name : 'gname',type:'string'}
     						
                          	],
                          	localdata: fleetdata,
                          //	 url: url1,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };

            $("#fleetSearch").on("bindingcomplete", function (event) {
            	$("#overlay, #PleaseWait").hide();
            });
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#fleetSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Fleet No', datafield: 'fleet_no', width: '10%' },
					{ text: 'Fleet Name', datafield: 'flname', width: '40%'},
					{ text: 'Reg No', datafield: 'reg_no', width: '10%' },
					{ text: 'Date', datafield: 'date', width: '10%' , cellsformat: 'dd.MM.yyyy' },
					{ text: 'Color', datafield: 'color', width: '10%' },
					{ text: 'Group', datafield: 'gname', width: '10%' },
					]
            });
    
            $('#fleetSearch').on('rowdoubleclick', function (event) 
				{ 
				  var rowindex1=event.args.rowindex;
				  document.getElementById("fleetno").value=$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "fleet_no"); 
				  $('#fleetwindow').jqxWindow('close');
				}); 	 
				           
                  }); 
				       
                       
    </script>
    <div id="fleetSearch"></div>
    