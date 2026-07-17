<%@page import="com.dashboard.audit.ClsAudit" %>
<% ClsAudit ca=new ClsAudit();%>
<%  String check=request.getParameter("check")==null?"0":request.getParameter("check").trim(); 
	String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();%>
<script type="text/javascript">
      var racolse;
      var temp='<%=branchval%>';
      alert(temp);
      
	  	if(temp!='NA'){ 
	  		alert("=== "+temp);
	  		racolse='<%=ca.rentalcloseaudit(branchval,check)%>';
	  		alert("=== "+racolse);
	  	}
  	
        $(document).ready(function () {
        	
        	      	
        	var source =
            {
                datatype: "json",
                datafields: [
					{ name: 'doc_no', type: 'int' },
					{ name: 'rano', type: 'int' },
					{ name: 'branchid', type: 'string' },
					{ name: 'client', type: 'string' },
					{ name: 'vehicle', type: 'string' },
                    { name: 'rentaltype', type: 'string' },
                    { name: 'total', type: 'number' },
                    { name: 'discount', type: 'number' },
                    { name: 'percent', type: 'string' },
                
	            ],
                localdata: racolse,
               
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
            $("#racloseaudit").jqxGrid(
            {
                width: '98%',
                height: 476,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                
                //Add row method
                columns: [
                          
						{ text: 'SL#', sortable: false, filterable: false, editable: false, 
						    groupable: false, draggable: false, resizable: false,
						    datafield: 'sl', columntype: 'number', width: '4%',
						    cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						    }  
						  },
						{ text: 'Agreement No', datafield: 'rano', width: '7%' },
						{ text: 'Client Name', datafield: 'client', width: '27%' },
						{ text: 'Vehicle', datafield: 'vehicle', width: '23%' },
	                    { text: 'Rental Type', datafield: 'rentaltype', width: '7%' },
	                    { text: 'Sum Of Total', datafield: 'total', cellsformat: 'd2' , width: '11%',cellsalign: 'right', align:'right' },
	                    { text: 'Sum Of Discount', datafield: 'discount', cellsformat: 'd2' , width: '11%' ,cellsalign: 'right', align:'right'},
	                    { text: 'Percentage', datafield: 'percent',  width: '10%',cellsalign: 'center', align:'center' },
	                    { text: 'Branch Id', hidden: true, datafield: 'branchid', width: '15%' },
	                    { text: 'docno',  datafield: 'doc_no', width: '15%',hidden:true }
					 ]
            });
     	   $("#overlay, #PleaseWait").hide();
            if(temp=='NA'){
                $("#racloseaudit").jqxGrid("addrow", null, {});
            }
            
            $('#racloseaudit').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtdocno").value = $('#racloseaudit').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtdocnoss").value = $('#racloseaudit').jqxGrid('getcellvalue', rowindex1, "rano");
                document.getElementById("txtbranchid").value = $('#racloseaudit').jqxGrid('getcellvalue', rowindex1, "branchid");
            }); 

        });

</script>
<div id="racloseaudit"></div>
