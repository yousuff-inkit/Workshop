<%@page import="com.workshop.carfaregateinpassmaster.*" %>
<%ClsCarfareGateInPassDAO crad =new ClsCarfareGateInPassDAO(); 
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
  $(document).ready(function () {     
	var insurancesurvivordata=[];
	var id='<%=id%>';
	if(id=='1'){
		insurancesurvivordata='<%=crad.getInsuranceSurvivorData(id)%>';
	}
	      		 var source =
	            {
	                datatype: "json",
	                datafields: [
	                          	{name : 'doc_no' , type: 'int' },
	     						{name : 'sal_name', type: 'String'  },
	                          	{name : 'mail', type: 'String'  },
	                          	{name : 'cldocno',type:'string'},
	                          	{name : 'refname',type:'String'},
	                          	{name : 'mobile',type:'string'},
	                          	{name : 'sal_code',type:'string'},
	                          	{name :'date',type:'date'},
	                          	{name : 'acdoc',type:'String'}
	                 ],
	                 localdata: insurancesurvivordata,
	                
	                
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
	            $("#insuranceSurvivorSearchGrid").jqxGrid(
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
	        					{ text: 'Code',datafield: 'sal_code', width: '10%',hidden:true },
	        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
	        					{ text: 'Name', datafield: 'sal_name', width: '20%' },
	        					{ text: 'Vendor',columntype: 'textbox', filtertype: 'input', datafield: 'refname', width: '30%' },
	        					{ text: 'Vendor No',columntype: 'textbox', filtertype: 'input', datafield: 'cldocno', width: '50%' ,hidden:true},
	        					{ text: 'Email',columntype: 'textbox', filtertype: 'input', datafield: 'mail', width: '15%' },
	        					{ text: 'Mobile',columntype: 'textbox', filtertype: 'input', datafield: 'mobile', width: '15%' },
	        					{ text: 'Ac No',columntype: 'textbox', filtertype: 'input', datafield: 'acdoc', width: '15%',hidden:true },

	        	              ]
	                    });

	            $('#insuranceSurvivorSearchGrid').on('rowdoubleclick', function (event) 
	            		{ 
	   		            	var rowindex1=event.args.rowindex;
	   		                document.getElementById("hidinsurancesurvivor").value= $('#insuranceSurvivorSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
	   		                document.getElementById("insurancesurvivor").value = $("#insuranceSurvivorSearchGrid").jqxGrid('getcellvalue', rowindex1, "sal_name");
							$('#insurancesurvivorwindow').jqxWindow('close');
	            		 }); 
	      		  
	      		  
	      		  
	     		
	     		
	     		
      		 });
</script>
<div id="insuranceSurvivorSearchGrid"></div>