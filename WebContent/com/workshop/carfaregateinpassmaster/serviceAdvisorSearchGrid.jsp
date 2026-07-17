<%@page import="com.workshop.carfaregateinpassmaster.*" %>
<%ClsCarfareGateInPassDAO dao=new ClsCarfareGateInPassDAO(); 
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script>
	$(document).ready(function(){
	var serviceadvisordata=[];
	var id='<%=id%>';
	if(id=='1'){
		serviceadvisordata='<%=dao.getServiceAdvisorData(id)%>';
	}
	      		 var source =
	            {
	                datatype: "json",
	                datafields: [
	                          	{name : 'doc_no' , type: 'int' },
	     							{name : 'name', type: 'String'  },
	                          	{name : 'mail', type: 'String'  },
	                          	{name : 'acno',type:'string'},
	                          	{name : 'description',type:'String'},
	                          	{name : 'mobile',type:'string'},
	                          	{name : 'code',type:'string'},
	                          	{name :'date',type:'date'},
	                          	{name : 'acdoc',type:'String'}
	                 ],
	                 localdata: serviceadvisordata,
	                
	                
	                pager: function (pagenum, pagesize, oldpagenum) {
	                    // callback called when a page or page size is changed.
	                }
	            };
	            
	            var dataAdapter = new $.jqx.dataAdapter(source,
	            		 {
	                		loadError: function (xhr, status, error) {
	   	                   // alert(error);    
	   	                    }
	   		            }		
	            ); 
	            $("#serviceAdvisorSearchGrid").jqxGrid(
	                    {
	                    	width: '100%',
	                    	height:310,
	                        source: dataAdapter,
	                        showfilterrow: true,
	                        filterable: true,
	                        selectionmode: 'singlerow',
	                        sortable: true,
	                        altrows:true,
	                        //Add row method
	                        columns: [
	        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
	        					{ text: 'Code',datafield: 'code', width: '10%',hidden:true },
	        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
	        					{ text: 'Name', datafield: 'name', width: '20%' },
	        					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '30%' },
	        					{ text: 'Account No',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '50%' ,hidden:true},
	        					{ text: 'Email',columntype: 'textbox', filtertype: 'input', datafield: 'mail', width: '15%' },
	        					{ text: 'Mobile',columntype: 'textbox', filtertype: 'input', datafield: 'mobile', width: '15%' },
	        					{ text: 'Ac No',columntype: 'textbox', filtertype: 'input', datafield: 'acdoc', width: '15%',hidden:true },

	        	              ]
	                    });

	            $('#serviceAdvisorSearchGrid').on('rowdoubleclick', function (event) 
	            { 
	   		            	var rowindex1=event.args.rowindex;
	   		                document.getElementById("hidserviceadvisor").value= $('#serviceAdvisorSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
	   		                document.getElementById("serviceadvisor").value = $("#serviceAdvisorSearchGrid").jqxGrid('getcellvalue', rowindex1, "name");
							$('#serviceadvisorwindow').jqxWindow('close');
	            }); 
      		 });
		</script>
		<div id="serviceAdvisorSearchGrid"></div>
</script>