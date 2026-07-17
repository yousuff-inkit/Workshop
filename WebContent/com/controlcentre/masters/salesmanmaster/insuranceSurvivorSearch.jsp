<%@page import="com.controlcentre.masters.salesmanmaster.insurancesurvivor.*" %>
<%ClsInsuranceSurvivorDAO ca=new ClsInsuranceSurvivorDAO(); %>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<script type="text/javascript">

  var datasearch= '<%=ca.searchDetails()%>';
        
  		$(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'sal_code', type: 'String'  },
                          	{name : 'sal_name', type: 'String'  },
                          	{name : 'date', type: 'String'  },
                          	{name : 'acc_no', type: 'String'  },
                          	{name : 'description', type: 'String'  },
                        	{name : 'mobile',type:'String'},
                          	{name : 'mail',type:'String'},
                          	{name : 'refname',type:'string'},
                          	{name : 'cldocno',type:'number'},
                          	{name : 'active',type:'number'},
                          	],
               localdata: datasearch,
                
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
            $("#jqxRentalAgentSearch").jqxGrid(
            {
            	width: '100%',
                height: 340,
                source: dataAdapter,
                sortable: true,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlerow',
                columnsresize: true,
                showfilterrow:true,
                
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Code', datafield: 'sal_code', width: '15%' },
					{ text: 'Name', datafield: 'sal_name', width: '40%' },
					{ text: 'Vendor No', datafield: 'cldocno', width: '40%',hidden:true },
					{ text: 'Vendor Name', datafield: 'refname', width: '35%' },
					{ text:'Mobile',datafield:'mobile', width: '40%',hidden:true },
					{ text:'Mail',datafield:'mail', width: '40%',hidden:true },
					{ text:'Active',datafield:'active', width: '40%',hidden:true }
					]
            });
           
            $('#jqxRentalAgentSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxRentalAgentSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                //document.getElementById("txtaccno").value = $("#jqxRentalAgentSearch").jqxGrid('getcellvalue', rowindex1, "acc_no");
                //document.getElementById("txtaccname").value = $("#jqxRentalAgentSearch").jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("code").value = $("#jqxRentalAgentSearch").jqxGrid('getcellvalue', rowindex1, "sal_code");
                document.getElementById("name").value = $("#jqxRentalAgentSearch").jqxGrid('getcellvalue', rowindex1, "sal_name");
                document.getElementById("mobile").value = $("#jqxRentalAgentSearch").jqxGrid('getcellvalue', rowindex1, "mobile");
                document.getElementById("mail").value = $("#jqxRentalAgentSearch").jqxGrid('getcellvalue', rowindex1, "mail");
                $("#rentalagentdate").jqxDateTimeInput('val', $("#jqxRentalAgentSearch").jqxGrid('getcellvalue', rowindex1, "date"));
               document.getElementById("cldocno").value = $("#jqxRentalAgentSearch").jqxGrid('getcellvalue', rowindex1, "cldocno");
                document.getElementById("clientname").value = $("#jqxRentalAgentSearch").jqxGrid('getcellvalue', rowindex1, "refname");
                document.getElementById("cmbactive").value = $("#jqxRentalAgentSearch").jqxGrid('getcellvalue', rowindex1, "active");
                
                $('#window').jqxWindow('hide');
            }); 
         
        });
</script>
<div id="jqxRentalAgentSearch"></div>
