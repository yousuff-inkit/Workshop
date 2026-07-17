<%@page import="com.operations.vehicletransactions.quickserviceupdate.ClsQuickServiceUpdateDAO"%>
<% String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").toString();
String fleet=request.getParameter("fleet")==null?"0":request.getParameter("fleet").toString();
String regno=request.getParameter("regno")==null?"0":request.getParameter("regno").toString();
String date=request.getParameter("date")==null?"0":request.getParameter("date").toString();
ClsQuickServiceUpdateDAO updatedao=new ClsQuickServiceUpdateDAO();
%>
<script type="text/javascript">

      var fleetdata='<%=updatedao.getFleet(docno,fleet,regno,date)%>';	

        $(document).ready(function () { 	
       
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'flname',type:'String'},
     						{name : 'fleet_no',type: 'String'},
     						{name : 'reg_no',type: 'String'}
     						
                 ],
                localdata: fleetdata,
                //url: url,
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
            $("#gridFleetSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                sortable: false,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
							{ text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy'},
						 	{ text: 'Fleet No', datafield: 'fleet_no', width: '20%'},
							{ text: 'Fleet Name', datafield: 'flname', width: '20%'},
							{ text: 'Reg No', datafield: 'reg_no', width: '20%' }
				
							]
            });
           
            $('#gridFleetSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
             	document.getElementById("fleetno").value=$('#gridFleetSearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
             	document.getElementById("fleetname").value=$('#gridFleetSearch').jqxGrid('getcellvalue', rowindex1, "flname");
             	
			$('#fleetwindow').jqxWindow('close');

            }); 
            var rows=$('#gridFleetSearch').jqxGrid('getrows');
            if(rows.length==0){
            $("#gridFleetSearch").jqxGrid("addrow", null, {});
            }
        });
    </script>
    <div id="gridFleetSearch"></div>
