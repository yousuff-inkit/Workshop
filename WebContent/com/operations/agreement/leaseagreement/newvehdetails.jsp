 <%@page import="com.operations.agreement.leaseagreement.ClsLeaseAgreementDAO" %>
 <%
 ClsLeaseAgreementDAO viewDAO= new ClsLeaseAgreementDAO();

	String vehdivdoc = request.getParameter("vehdivdoc")==null?"NA":request.getParameter("vehdivdoc").trim(); 
 %>	
<script type="text/javascript">

var temp2='<%=vehdivdoc%>'; 

var newvehdata;
if(temp2!="NA")
{


 newvehdata='<%=viewDAO.otherincomedivrelode(vehdivdoc)%>';


}
else
{ 

 newvehdata;

} 
      


        $(document).ready(function () {
        	
       


        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'name' , type: 'string' },
							{name : 'price' , type:'number'},
						
							
	                      ],
                          localdata: newvehdata,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	


            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#nwevehgrid").jqxGrid(
            {
            	  width: '100%',
                  height: 127,
                  source: dataAdapter,
                  columnsresize: true,
                  rowsheight:20,
                  disabled:true,
                  editable:true,
                  selectionmode: 'singlecell',
                  pagermode: 'default',
                  theme: theme,
                //Add row method
                columns: [   
							
							{ text: 'Name',  datafield: 'name',  width: '60%' },
							{ text: 'Price',  datafield: 'price',cellsformat:'d2' , width: '40%',cellsalign: 'right',align: 'right'},
							
				 ]
            });
            
            if(temp2=="NA")
            {
            $("#nwevehgrid").jqxGrid('addrow', null, {});
            $("#nwevehgrid").jqxGrid('addrow', null, {});
            $("#nwevehgrid").jqxGrid('addrow', null, {});
            $("#nwevehgrid").jqxGrid('addrow', null, {});
            $("#nwevehgrid").jqxGrid('addrow', null, {});

            }
            
            if ($("#mode").val() == "view") {
            	   $('#nwevehgrid').jqxGrid({ disabled: true}); 
            }
             
             if ($("#mode").val() == "A") {
             	   
             	  
            	   $('#nwevehgrid').jqxGrid({ disabled: false}); 
              
            	 
                }
            
         
            
            $("#nwevehgrid").on('cellendedit', function (event) 
            		{

           		    var dataField = event.args.datafield;
            		    
           		    
           		    var rowindex1 = event.args.rowindex;
           		 if(dataField=="price")
                 {
            		    
            		    var rows = $('#nwevehgrid').jqxGrid('getrows');
                        var rowlength= rows.length;
                        if(rowindex1==rowlength-1)
                        {
                        $("#nwevehgrid").jqxGrid('addrow', null, {});	
                        } 
                 }
            		});
          
            
   
        
        });

</script>
<div id="nwevehgrid"></div>
