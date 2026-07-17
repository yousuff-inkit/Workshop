<%@page import="com.dashboard.operations.drvragmtinvoicelist.ClsdriveragreementinvoicelistDAO" %>
<%
	ClsdriveragreementinvoicelistDAO cid=new ClsdriveragreementinvoicelistDAO();
%>
       <script type="text/javascript">
  
	    var data='<%=cid.driverDetailsSearch()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'doc_no' , type: 'number' },
						{name : 'code', type: 'String'  },
						{name : 'name', type: 'String'    },
						{name : 'license', type: 'String'  },
						{name : 'licenseexpdate',type:'date'},
						{name : 'mobile',type:'string'}
     						
                        ],
                		
                		//  url: url1,
                 localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#driversearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                            { text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true},
                            { text: 'Code',datafield:'code',width:'10%'},
                            { text: 'Name', datafield: 'name', width: '50%'},
                            { text: 'License No',datafield:'license',width:'10%'},
                            { text: 'License Exp Date',datafield:'licenseexpdate',width:'10%',cellsformat:'dd.MM.yyyy'},
                            { text: 'Mobile', datafield: 'mobile', width: '20%'}
						]
            });
            
          $('#driversearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("txtdrivername").value=$('#driversearch').jqxGrid('getcellvalue', rowindex2, "name");
                document.getElementById("txtdrdocno").value=$('#driversearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                
               $('#driverDetailsWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="driversearch"></div>