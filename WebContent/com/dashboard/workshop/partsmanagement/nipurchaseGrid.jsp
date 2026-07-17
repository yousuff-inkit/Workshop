  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%@page import="com.dashboard.workshop.partsmanagement.*" %>
 
<%

CLSpartsManagementDAO partsdao=new CLSpartsManagementDAO();

%>
<%
String nipurdoc=request.getParameter("rowno")==null?"0":request.getParameter("rowno").trim();


//System.out.println("=========nipurdoc====="+nipurdoc);


%>
<script type="text/javascript">
var descdatas;

var temp='<%=nipurdoc%>';

	descdatas='<%=partsdao.reloadnipurchase(nipurdoc)%>';  


        $(document).ready(function () { 	
       
            
        	  var rendererstring1=function (aggregates){
               	var value=aggregates['sum1'];
               	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
               }
         var rendererstring=function (aggregates){
         	var value=aggregates['sum'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">'  + value + '</div>';
         }
        
               
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [//srno, description, unitprice, qty, total, discount, nettotal, nuprice, acno, costtype, costcode, remarks, account, description, atype, CostGroup
     						
                                {name : 'type', type: 'string'  },
								{name : 'account', type: 'number'    },
								{name : 'accname', type: 'string'    },
								{name : 'description', type: 'string'    },
								{name : 'qty', type: 'number'    },
								{name : 'unitprice', type: 'number'    },
								{name : 'total', type: 'number'    },
								{name : 'discount', type: 'number'    },
								{name : 'nettotal', type: 'number'    },
								{name : 'costtype', type: 'string'    },
								{name : 'costgroup', type: 'string'    },
								
								{name : 'costcode', type: 'nember'    },
								{name : 'nuprice', type: 'number'    },
								{name : 'remarks', type: 'string'    },
								
								
								{name : 'headdoc', type: 'number'    },
								{name : 'qutval', type: 'number'    },
								{name : 'grtype', type: 'number'    },
								
								{name : 'refrow', type: 'number'    },
								
								
	        					 {name : 'taxper', type: 'number'  },  
	        					 {name : 'taxamount', type: 'number'  },
	        					{name : 'taxperamt', type: 'number'  },
								
								
                 ],              
              
                 localdata: descdatas,
                
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

            
            
            $("#nidescdetailsGrid").jqxGrid(
            {
            	 width: '99%',
                 height: 250,
                 source: dataAdapter,
                 showaggregates:true,
                 showstatusbar:true,
                 filterable: true,
                 editable:true,
                 statusbarheight: 25,
                 selectionmode: 'singlecell',
                 sortable:false,
                       columns: [
                
							   { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '2%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
				
                           
				
							{ text: 'Description', datafield: 'description', width: '30%' ,editable: true},
							{ text: 'Qty', datafield: 'qty', width: '3%', cellsalign: 'left', align:'left',editable:true},
							{ text: 'Unit Price', datafield: 'unitprice', width: '6%',cellsalign: 'right', align:'right',editable:true },
							{ text: 'Total', datafield: 'total', width: '6%',cellsformat:'d2',cellsalign: 'right', align:'right', editable:false},
							{ text: 'Discount', datafield: 'discount', width: '6%',cellsalign: 'right', align:'right',cellsformat:'d2',editable:true ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
							{ text: 'Net Total', datafield: 'nettotal', width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable:false},
							{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:true},
							{ text: 'Tax Amount', datafield: 'taxperamt', width: '15%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Total Tax Amount', datafield: 'taxamount', width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
							{ text: 'Type', datafield: 'type', width: '4%', cellsalign: 'center',align: 'center',columntype:'dropdownlist',hidden:true,createeditor: function (row, column, editor) {
	                                editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
	                            }
	     					    },
							{ text: 'Account', datafield: 'account', width: '4%' ,editable: false,cellsalign: 'center', align:'center',hidden:true},
							{ text: 'Account Name', datafield: 'accname', width: '12%' ,editable: false,hidden:true},
							{ text: 'Cost Type', datafield: 'costgroup', width: '8%',editable: false,hidden:true},
							{ text: 'Cost Code', datafield: 'costcode', width: '6%',editable: false ,hidden:true},
							{ text: 'Remarks', datafield: 'remarks', width: '20%' ,editable: true,hidden:true},
							{ text: 'Qutval', datafield: 'qutval', width: '20%',editable: true,hidden:true},
							{ text: 'nuprice', datafield: 'nuprice', width: '9%',cellsformat:'d2',editable: true,hidden:true},
							{ text: 'Head doc', datafield: 'headdoc', width: '20%',editable: true,hidden:true},     /* for account name, acccount from my head then save this number in table*/ 
							{ text: 'Cost id', datafield: 'costtype', width: '8%',hidden:true ,editable: true},
							{ text: 'grtype', datafield: 'grtype', width: '20%',editable: true,hidden:true},  /* this for grrtype=4 and 5 then take cost code and costtype*/ 
							{ text: 'refrow', datafield: 'refrow', width: '20%',editable: true,hidden:true}, 
	              ]
            });
            
            //$("#nidescdetailsGrid").jqxGrid('addrow', null, {});
            
            /* if(($('#mode').val()=='A')||($('#mode').val()=='E'))
    		{
    		  $("#nidescdetailsGrid").jqxGrid({ disabled: false}); 
    		}
            
 */           
           /*  $("#nidescdetailsGrid").jqxGrid('addrow', null, {}); */
            
            
           
        
            
          /* $("#nidescdetailsGrid").on('cellclick', function (event) 
            		{
        
        	   var rowindextemp2 = event.args.rowindex;
               document.getElementById("rowindex").value = rowindextemp2;
               document.getElementById("rowindex1").value = rowindextemp2;
        /*        alert(event.args.datafield); */
               
               /* if(event.args.datafield=="account")
            	   {
            	
               $("#nidescdetailsGrid").jqxGrid('clearselection');
            	   }
               if(event.args.datafield=="costgroup")
        	   {
        	
               $("#nidescdetailsGrid").jqxGrid('clearselection');
        	   } 
               if(event.args.datafield=="costcode")
        	   {
        	
               $("#nidescdetailsGrid").jqxGrid('clearselection');
        	   } 
               
           
               
                    });  
         */
          
           /*  $('#nidescdetailsGrid').on('celldoubleclick', function (event) {
            	
            	  var refno=document.getElementById("ordermasterdoc_no").value;

 			if(event.args.datafield=="description"&&(refno==""||parseInt(refno)<=0))
          	   {
          		 var rowindextemp = event.args.rowindex;
                 document.getElementById("prdsetrowno").value = rowindextemp;
          		getproductdetails();
          	   }
            	 // alert(""+refno);
                  if(parseInt(refno)>0)
      			     {	
            	  if(event.args.datafield=="description")
            	   {
          
                   var rowindextemp = event.args.rowindex;
                   document.getElementById("rowindex1").value = rowindextemp; */
                  
               /*  $('#nidescdetailsGrid').jqxGrid('clearselection'); 
                 
                      var values = document.getElementById("ordermasterdoc_no").value;
             
                      nipurhsaeslnocontent('nislnosearch.jsp?niorder='+values);
                          } 
            	  
            	  
      			     }
            	
                if(event.args.datafield=="account")
         	   {
         	
                var rowindextemp = event.args.rowindex;
                document.getElementById("rowindex1").value = rowindextemp;
               
                $('#nidescdetailsGrid').jqxGrid('clearselection');
                   var value = $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowindextemp, "type");
                         CashSearchContent('accountGridSearch.jsp?atype='+value);
                       } 
                if(event.args.datafield=="costgroup")
         	   {
               var rowindextemp1 = event.args.rowindex;
               document.getElementById("rowindex").value = rowindextemp1;
               $('#nidescdetailsGrid').jqxGrid('clearselection');
               var value = $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowindextemp1, "grtype"); 
               if(value==4 || value==5){
                        costSearchContent('costtypegridsearch.jsp?');
                    }
                        
                      } 
                if(event.args.datafield=="costcode")
         	   {
         	
               var rowindextemp2 = event.args.rowindex;
               document.getElementById("rowindex").value = rowindextemp2;
               $('#nidescdetailsGrid').jqxGrid('clearselection');
               
               var value = $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowindextemp2, "grtype"); 
               if(value==4 || value==5){
               
                  var values = $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowindextemp2, "costtype");
                  var aa="nidescdetailsGrid";
                  costcodeSearchContent('../../../../com/costcenter/costCodeSearchGrid.jsp?costtype='+values+'&formname='+aa);
                  
                           }
                      } 
                 
                
                
                 }); */
            	
            function valchange(rowBoundIndex)
            {
              /*   var qutval=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "qutval");	
   	            var qty;
               	 
               var quty=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
               var refno=document.getElementById("refno").value;
               
               if(parseInt(refno)>0)
   			     {
            	if(quty>qutval)
            		{
            
            		document.getElementById("errormsg").innerText=" Qty value not more than Actual Qty  ";
            		qty=qutval;
            	 $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",qutval);
            	 
            	    }
		            	else
		        		{
		        		//document.getElementById("errormsg").innerText="";
		        		 qty= $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
		        		}
            	 
            		}
               
		               else
		       		{
		       		//document.getElementById("errormsg").innerText="";
		       		 qty= $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
		       		}
 */            	
 
                  
                var qty;
                qty= $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
            	var unitprice=	$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");	
            	var total=parseFloat(parseFloat(qty)*parseFloat(unitprice)).toFixed(2);
           
    		    $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
    		    
    		   var gtotal= $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
				  
    	   		var discount=	$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "discount");	
    	   		if(discount==""||discount==null||discount=="undefiend")
	   			{
	   		  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "discount",0);
	   			} 		    
    	        		
    	   		var nettotal=parseFloat(parseFloat(gtotal)-parseFloat(discount)).toFixed(2);
    	   		if(discount==""||discount==null||discount=="undefiend")
    	   			{
    	   		  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",total);
    	   			}
    	   		else{
    	   			$('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",nettotal);
    	   		}
    	        		    
    	   	 			document.getElementById("roundoff").value=0;
    	   		 
    	        		    var summaryData= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
    	                    //alert("ssssss"+summaryData.sum);
    	                    document.getElementById("nettotal").value=summaryData.sum;
    	                    
    	        		    var summaryData1= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
    	                    //alert("ssssss"+summaryData.sum);
    	                    var aa=parseFloat(summaryData1.sum.replace(/,/g,'')).toFixed(2);
    	                    funRoundAmt(aa,"nettotalval");
    	                 
    	                    
    	                    $('#nettotalval').attr('readonly', true);
    	                    
    	                    var nettotalval=  $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal");
    	                    var nuprice=parseFloat(parseFloat(nettotalval)/parseFloat(qty)).toFixed(2);
    	                   // alert("nuprice"+nuprice);
    	                    $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nuprice",nuprice);
            }

            $("#nidescdetailsGrid").on('cellvaluechanged', function (event) 
            {
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		    
    		   /*  if(datafield=="type")
    		    {
    		        		    	document.getElementById("acctypegrid").value=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "type");
    		    	
    		    }
    		    if(datafield=="costtype")
    		    {
    		    	//alert("");
    		    	document.getElementById("costgropename").value=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "costtype");
    		    	
    		    }
    		     */
    		    
    		     
            		if(datafield=="qty")
            		    {
            
            			valchange(rowBoundIndex);
            		    }
            		if(datafield=="unitprice")
        		    {
            			
            			valchange(rowBoundIndex);
        		    }
            		if(datafield=="discount")
        		    {
            			//$('#nidescdetailsGrid').jqxGrid('selectcell', rowBoundIndex, 'costgroup');
            			valchange(rowBoundIndex);
   				
        		    }
            		
            		/* if(datafield=="type")
        		    {
            			
            			
            	         $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "account","");
            	         $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "accname","");
            			
            			
            			
        		    }	 */
            		
            		  if(datafield=="taxper")
            		  {
            				var netotal=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal"); 
                    		
                    		
                  
                    		  var taxper= $('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "taxper"); 
                    		  if(parseFloat(taxper)>0)
                  			{ 
                    			  
                    			  
                    		  var taxempamount=parseFloat(parseFloat(netotal)*(parseFloat(taxper)/100)).toFixed(2);
                    		  
                    		  
                    		  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxempamount);
                    		  
                    		  var taxtotalamount=parseFloat(parseFloat(netotal)+parseFloat(taxempamount)).toFixed(2);
                    		  
                    		  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",taxtotalamount);
                  			}
                    		  
                    		  else
                    			  {
                    			  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",0);
                    			  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",netotal);
                    			  }
                    		  
                    		  
                    		  
                    		    
          	   	 			document.getElementById("roundoff").value=0;
          	   		 
          	        		    var summaryData= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
          	                    //alert("ssssss"+summaryData.sum);
          	                    document.getElementById("nettotal").value=summaryData.sum;
          	                    
          	        		    var summaryData1= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
          	                    //alert("ssssss"+summaryData.sum);
          	                    var aa=parseFloat(summaryData1.sum.replace(/,/g,'')).toFixed(2);
          	                    funRoundAmt(aa,"nettotalval");
          	                 
                    		  
            		  }
            		
            		
            		
            		
            	   	  if(datafield=="nettotal")
            		  {
            		var netotal=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal"); 
            		var taxpers=$('#nidescdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "taxper");
            		 
            		if(parseFloat(taxpers)>0)
            			{
            			 
        		 		 var taxper= taxpers; 
            		  
            		  var taxempamount=parseFloat(parseFloat(netotal)*(parseFloat(taxper)/100)).toFixed(2);
            		  
            		  
            		  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxempamount);
            		  
            		  var taxtotalamount=parseFloat(parseFloat(netotal)+parseFloat(taxempamount)).toFixed(2);
            		  
            		  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",taxtotalamount);
            			
            			}
            		else
            			{
            			 $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",0);
              		  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",netotal);
            			}
            		
    
            		  
            	    
	   	 				document.getElementById("roundoff").value=0;
	        		    var summaryData= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
	                    document.getElementById("nettotal").value=summaryData.sum;
	        		    var summaryData1= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
	                    var aa=parseFloat(summaryData1.sum.replace(/,/g,'')).toFixed(2);
	                    funRoundAmt(aa,"nettotalval");
	                 
            		 
            		  }
            		
            		 
            		});
/* 
            $("#nidescdetailsGrid").on('cellclick', function (event) 
            {
        		document.getElementById("errormsg").innerText="";
            		 
            		}); */
        });

       /*  function funinterstate()
		{
			
		   var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
			       var items= x.responseText.trim();
			       
			       var item = items.split('::');
					var itemval1  = item[0];
					var itemval2 = item[1];
			    
			       if(parseInt(itemval1)>0){
			    	   
			    	   $('#txtproducttype').show();
			    	   $('#billtype').show();
			    	      $('#nidescdetailsGrid').jqxGrid('showcolumn', 'taxper');
		            	  $('#nidescdetailsGrid').jqxGrid('showcolumn', 'taxamount');
		            	  $('#nidescdetailsGrid').jqxGrid('showcolumn', 'taxperamt');
		            	//  $('#nidescdetailsGrid').jqxGrid('hidecolumn', 'nettotal');
		            	  if($('#mode').val()=='E' || ($('#mode').val()=='A' && $('#nireftype').val()=="NPO"))
		            		  {
		            		  
		                  	if(parseInt(itemval2)>0)
		            		{
		                  		
		                  		
		                  		document.getElementById("validates").value=1;
		                  		
		   				 $('#txtproducttype').attr('readonly', true);
		   				 
		   				 
		   				 $('#txtproducttype').attr('disabled', false);
		            		
		            		}
		            	
		            	else
		            		{
		            		document.getElementById("validates").value=0;
		            		 $('#txtproducttype').attr('readonly', true);
			   				 
			   				 
			   				 $('#txtproducttype').attr('disabled', true);
		            		}
		            		  
		            		  }
		            	  
		            						
						
			       }
					else{
						   
						 $('#txtproducttype').hide();
				    	   $('#billtype').hide();
				    	   
				    	   
				    	   $('#nidescdetailsGrid').jqxGrid('hidecolumn', 'taxper');
			            	  $('#nidescdetailsGrid').jqxGrid('hidecolumn', 'taxamount');
			            	  $('#nidescdetailsGrid').jqxGrid('hidecolumn', 'taxperamt');
			            	  
			           //	  $('#nidescdetailsGrid').jqxGrid('showcolumn', 'nettotal');
				    	   
						
					}
					}
				else{
					
				}
				}
		x.open("GET","interstate.jsp?docnos="+document.getElementById("accdocno").value,true);

		x.send();
				
		} */
    </script>
    <div id="nidescdetailsGrid"></div>
   <input type="hidden" id="rowindex"/> 
      <input type="hidden" id="rowindex1"/> 
<input type="hidden" id="prdsetrowno"/>
