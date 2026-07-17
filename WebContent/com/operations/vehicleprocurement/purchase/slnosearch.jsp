<%@page import="com.operations.vehicleprocurement.purchase.ClsvehpurchaseDAO" %>
<%ClsvehpurchaseDAO cvp=new ClsvehpurchaseDAO(); %>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>

<%
String docnos = request.getParameter("docnos")==null?"0":request.getParameter("docnos");
/* out.print("-----"+docnos); */
%>

    <style type="text/css">
  .advanceClass
  {
      color: #FF0000;
  }
  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        /*   background-color: #eedd82;  */
        }
</style>
<script type="text/javascript">

var vahReqmaster1= '<%=cvp.slnosearch(docnos) %>'; 
            	
        $(document).ready(function () { 	
        
 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
 	                            {name : 'srno', type: 'string'  },
						      	{name : 'brand', type: 'string'  },
								{name : 'brdid', type: 'int'   },
								{name : 'model', type: 'string'   },
								{name : 'modid', type: 'string'   },
								{name : 'specification', type: 'string'  },
								{name : 'color', type: 'string'   },
								{name : 'clrid', type: 'string'   },
								{name : 'qty', type: 'number'  },
								{ name: 'price', type: 'number' },
								{ name: 'rdocno', type: 'number' }
													
     											
                 ],
                 localdata: vahReqmaster1,
                
                
                 
                 
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

         
            var cellclassname =  function (row, column, value, data) {


          	  var ss= $('#slnosearch').jqxGrid('getcellvalue', row, "qty");
          		          if(parseInt(ss)<=0)
          		  		{
          		  		
          		  		return "yellowClass";
          		  	
          		  		}
          	    
          	    	/* return "greyClass";
          	    	
          		        var element = $(defaultHtml);
          		        element.css({ 'background-color': '#F3F297', 'width': '100%', 'height': '100%', 'margin': '0px' });
          		        return element[0].outerHTML;
          	*/

          		}
            
            $("#slnosearch").on("bindingcomplete", function (event) {
            	
            	
            	var rows = $("#slnosearch").jqxGrid('getrows');

            		//  var srno=$('#slnosearch').jqxGrid('getcellvalue', rows, "srno");
				    //var qty=$('#slnosearch').jqxGrid('getcellvalue', rows, "qty");
				   
				   
				   for(var i=0 ; i < rows.length ; i++){
					   
			         
					   
					   var srno=$('#slnosearch').jqxGrid('getcellvalue', i, "srno");
					   var qty=$('#slnosearch').jqxGrid('getcellvalue', i, "qty");
					   
					 
					   
					
			           var tempval="0";
		                
		               
		              	
		                var rows = $("#vehoredergrid").jqxGrid('getrows');
		    		  
		    		   for(var j=0 ; j < rows.length ; j++){
		    			   
		    			   //alert(rows[i].tempval);
		    			   
		    			   
		    		
		    	 	if(typeof(rows[j].tempval)!="undefined" && rows[j].tempval!="" )
		    			{ 
		    	 		if(parseInt(srno)==rows[j].srno)
						   {
		    	 		tempval=parseInt(tempval)+parseInt(rows[j].tempval);
		    			    } 
		    	 	     
		    			}
		    	 	if(parseInt(tempval)==0)
		    	 		{
		    	 	  $('#slnosearch').jqxGrid('setcellvalue', i, "qty" ,qty);
		    	 		}
		    	 	else
		    	 		{
		    	 	$('#slnosearch').jqxGrid('setcellvalue', i, "qty" ,parseInt(qty)-parseInt(tempval));
		    	 		}
		    		   
		    		   } 
					   
					   
					   
					   
	    			}    
					   
				   
            	
            	
            });   
    
            $("#slnosearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
             
                
          
          

                       
                columns: [

                           { text: 'Sr No', datafield: 'srno', width: '6%' ,cellclassname: cellclassname},
                        	{ text: 'Brand', datafield: 'brand', width: '20%' ,cellclassname: cellclassname},	
            				{ text: 'Model', datafield: 'model', width: '20%' ,cellclassname: cellclassname},
            				{ text: 'Specification', datafield: 'specification', width: '20%',cellclassname: cellclassname },	
            				{ text: 'Color', datafield: 'color', width: '12%' ,cellclassname: cellclassname},
            				{ text: 'Qty', datafield: 'qty', width: '9%',cellclassname: cellclassname},
            				{ text: 'Price', datafield: 'price', width: '13%',cellsformat: 'd2',cellsalign: 'right', align: 'right',cellclassname: cellclassname},
            				{ text: 'Brandid', datafield: 'brdid', width: '2%',hidden:true ,cellclassname: cellclassname},
            				{ text: 'Modelid', datafield: 'modid', width: '2%',hidden:true ,cellclassname: cellclassname},
            				{ text: 'Colorid', datafield: 'clrid', width: '10%',hidden:true ,cellclassname: cellclassname},
            				{ text: 'rdocno', datafield: 'rdocno', width: '10%',hidden:true,cellclassname: cellclassname },
            				
							
			              ]
               
            });
            
            function noqty()
            {
            
            setInterval(function(){ 
            	
            	document.getElementById("errormsg").innerText="";
            	
            	
            }, 5000);
            return 0;
            }
          /*   
            $('#slnosearch').on('rowclick', function (event) {
            	document.getElementById("errormsg").innerText="";	
            });
             */
            
            $('#slnosearch').on('rowdoubleclick', function (event) {
            
            	var rowindex1 =$('#rowindex').val();
            	
            	
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                
                 var qtyvalidate=$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "qty");
                
                if(parseInt(qtyvalidate)<=0)
                	{

            		document.getElementById("errormsg").innerText="Quantity Is Zero ";
            		noqty();
            		return 0;
                	
                	}
                else
                	{
                	document.getElementById("errormsg").innerText="";
                	}
                
                
                
                
                
                
                $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "brand" ,$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "brand"));
                $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "brdid" ,$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "brdid"));
                $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "model" ,$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "model"));
                $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "modid" ,$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "modid"));
                $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "color" ,$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "color"));
                $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "clrid" ,$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "clrid"));
                $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "specification" ,$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "specification"));
               /*  $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "qty" ,$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "qty")); */
                $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "price" ,$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "price"));
                $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "srno" ,$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "srno"));
                
               // var sr1=$('#vehoredergrid').jqxGrid('getcellvalue', rowindex1, "srno");
                var sr2=$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "srno");
                
               
                var tempval="0";
                
               
              	
                var rows = $("#vehoredergrid").jqxGrid('getrows');
    		  
    		   for(var i=0 ; i < rows.length ; i++){
    			   
    			   //alert(rows[i].tempval);
    			   
    			   
    		
    	 	if(typeof(rows[i].tempval)!="undefined" && rows[i].tempval!="" )
    			{ 
    	 		if(parseInt(sr2)==rows[i].srno)
				   {
    		
    			
    			
    			
    	 		tempval=parseInt(tempval)+parseInt(rows[i].tempval);
    			//diff=tempval+rows[i].tempval;
    			 } 
    	 	     
    			}
    	 	
    		   }   
    		//alert(tempval);
    		   
    		var x=new XMLHttpRequest();
            
           	
           	x.onreadystatechange=function(){
           	if (x.readyState==4 && x.status==200)
           		{
           		 	var items= x.responseText.trim();
           		// alert(items); 	
           		items = items.split('::');
    			var tempval = items[0].split(",");
    			var diff = items[1].split(",");
           		 
           		// $('#slnosearch').jqxGrid('setcellvalue', rowindex2, "srno",items);	
           	  $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "tempval" ,tempval);
          	
           	  $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "diff" ,diff);     
           		 		
           		 }
           	       else
           		  {
           	    	   
           		  }
               }
           	x.open("GET", 'updateqty.jsp?srno='+$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "srno")+'&docno='+$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "rdocno")+'&tempval='+tempval+'&qty='+$('#slnosearch').jqxGrid('getcellvalue', rowindex2, "qty"), true);
               x.send();
                
                var rows = $('#vehoredergrid').jqxGrid('getrows');
                var rowlength= rows.length;
                if (rowindex1 == rowlength - 1) {
                    
                    $("#vehoredergrid").jqxGrid('addrow', null, {});	
                    
                    }	
                $('#slnosearchwindow').jqxWindow('close');
               
            }); 
              	  
   
        });
    </script>
    <div id=slnosearch></div>
