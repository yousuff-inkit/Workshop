<%@page import="com.dashboard.serviceandmaintenance.ClsServiceAndMaintenanceDAO"%>
<%ClsServiceAndMaintenanceDAO DAO= new ClsServiceAndMaintenanceDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
     String fleetno = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno").trim();
     String id = request.getParameter("id")==null?"0":request.getParameter("id").trim(); %>
     <% String contextPath=request.getContextPath();%>
<script type="text/javascript">
      var data2;
      var temp='<%=branchval%>';
      var temp1='<%=type%>';
      var id='<%=id%>';
      if(id=="1"){
    	if(temp!='NA'){ 
	  		   data2='<%=DAO.accidentHistory(branchval, fromDate, toDate, fleetno,id)%>';
	  	}  
      }
	  	
	  	
  	
        $(document).ready(function () {
        	/*if(temp1=='1'){
	        	$("#btnExcel").click(function() {
	    			$("#accidentHistory").jqxGrid('exportdata', 'xls', 'AccidentHistory');
	    		});
        	}*/
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'fleet_no' , type: 'int' },
							{name : 'reg_no' , type: 'int' },
							{name : 'date' , type: 'date' },
							{name : 'policereport' , type:'string'},
							{name : 'collectiondate' , type:'date'},
							{name : 'place' , type:'string'},
							{name : 'fine',type:'number'},
							{name : 'claim' , type:'string'},
							{name : 'remarks' , type:'string'},
							{name : 'doc_no' , type: 'int' }
	                      ],
                          localdata: data2,
               
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
            $("#accidentHistory").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Fleet No',  datafield: 'fleet_no',  width: '5%' },
							{ text: 'Reg No.',  datafield: 'reg_no',  width: '5%' },
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '10%' },
							{ text: 'Police Report',  datafield: 'policereport',  width: '17%' },
							{ text: 'Collection Date',  datafield: 'collectiondate', cellsformat: 'dd.MM.yyyy' ,  width: '10%'  },
							{ text: 'Place', datafield:'place', width:'14%' },
							{ text: 'Fines',  datafield: 'fine',  width: '8%', cellsformat: 'd2',cellsalign:'right',align:'right' },
							{ text: 'Claim',  datafield: 'claim',  width: '8%' },
							{ text: 'Remarks',  datafield: 'remarks',  width: '23%'},
							{ text: 'Doc No',  datafield: 'doc_no',  hidden: true, width: '10%'},
						 ]
            });
            
            if(temp=='NA'){
                $("#accidentHistory").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#accidentHistory').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtvehdocno").value = $('#accidentHistory').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
                var url=document.URL;
				var reurl=url.split("com/");
				
				var detName= "Vehicle Inspection";
				var path= "com/operations/vehicletransactions/vehicleinspection/inspectionDetails.action?mode=view&docno="+document.getElementById("txtvehdocno").value;
				top.addTab( detName,reurl[0]+""+path);
            
            });  

        });

</script>
<div id="accidentHistory"></div>
