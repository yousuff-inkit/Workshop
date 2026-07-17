

<%@page import="com.operations.marketing.quotation.ClsquotationDAO" %>

<%

ClsquotationDAO viewDAO=new ClsquotationDAO();

%>

 <%
 
 String qutdocno3 = request.getParameter("qutdocno3")==null?"0":request.getParameter("qutdocno3").trim();
 %>
<script type="text/javascript">



        
           /*  var url = "qotationtxt.txt"; */
           	var temp1='<%=qutdocno3%>';
	
    var hide;
    
   
  if(temp1>0)
  	 { 
	
	  var quotdesc1='<%=viewDAO.descsaverelode(qutdocno3)%>';
  	   hide=2; 
  	 } 
    else
    	{
         
             var quotdesc1;
    	}
  
  
  $(document).ready(function () {
             var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'srno' , type: 'int' },
     						{name : 'description', type: 'string'  },
     						{name : 'desid', type: 'string'  },
     						{name : 'descplus', type: 'string'    }
     						
     						
     						
                 ],
                /* url: url, */
                         localdata: quotdesc1,
                
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

            
            
            $("#descgrid").jqxGrid(
            {
                width: '100%',
                height: 67,
               
                source: dataAdapter,
           
                editable: true,
                altRows: true,
                rowsheight:20,
                disabled:true,
               
                selectionmode: 'singlecell',
                pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                   
                	 if(args.datafield=="description")
                 	{
                 
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {                                                      
                        	descinfoSearchContent('descsubSearch.jsp');
                        }
                    }
                },  
                
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '3%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
							{ text: 'Desription', datafield: 'description', width: '47%' ,editable: false},
							{ text: 'Desriptionid', datafield: 'desid', width: '3%',hidden:true },
							{ text: 'Desription Plus', datafield: 'descplus', width: '50%' },
							{ text: 'srno', datafield: 'sr_no', width: '9%',hidden:true}
							
							
	              ]
            });
            $("#descgrid").jqxGrid('addrow', null, {});
            
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
           	{
       	     $("#descgrid").jqxGrid({ disabled: false}); 
          	}
           
            
            $("#qutgrid").on('cellclick', function (event) 
             		{
         
         	   var rowindextemp2 = event.args.rowindex;
                document.getElementById("rowindex7").value = rowindextemp2;
               
                if(event.args.columnindex ==1)
             	   {
             	
                $("#descgrid").jqxGrid('clearselection');
             	   }
               
            
                
                     }); 
            $('#descgrid').on('celldoubleclick', function (event) {
            	var columnindex1=event.args.columnindex;
              	  if(columnindex1 == 1)
              		  { 

              	 var rowindextemp1 = event.args.rowindex;
              	    document.getElementById("rowindex7").value = rowindextemp1;  
              	   
              	descinfoSearchContent('descsubSearch.jsp');
              	
              		  } 
      
        	  
              	
              	  
                  }); 
        });
    </script>
    <div id="descgrid"></div>
     <input type="hidden" id="rowindex7"/> 
