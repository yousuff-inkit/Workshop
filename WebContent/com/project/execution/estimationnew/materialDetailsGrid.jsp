<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
 <%@page import="com.project.execution.estimationnew.ClsEstimationDAO"%>
<%ClsEstimationDAO DAO= new ClsEstimationDAO();%>
 
<%
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
String trno=request.getParameter("trno")==null?"0":request.getParameter("trno").trim();
String aid = request.getParameter("aid")==null?"0":request.getParameter("aid");
int loadid =request.getParameter("loadid")==null?0:Integer.parseInt(request.getParameter("loadid").trim()); 
String enqtrno=request.getParameter("enqtrno")==null?"0":request.getParameter("enqtrno").trim();
String surtrno=request.getParameter("surtrno")==null?"0":request.getParameter("surtrno").trim();
%>

<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .greyClass
    {
        background-color: #D8D8D8;
    }
              
</style>

<script type="text/javascript">
var matdata;
$(document).ready(function () {
   var docno='<%=docno%>';
   var trno='<%=trno%>';
   var enqtrno='<%=enqtrno%>';
   var surtrno='<%=surtrno%>';
   var loadid=parseInt('<%=loadid%>');

   
   if(loadid==1){
	   
	   matdata='<%=DAO.materialGridLoad(session,docno)%>';
   }
   else if(loadid==2){
	  
	   matdata='<%=DAO.materialGridReLoad(session,trno)%>';
   }
   else if(loadid==3){
		  
	    matdata='<%=DAO.materialGridSiteLoad(session,enqtrno,loadid)%>' ;
   } 
   else if(loadid==4){
		  
	   matdata='<%=DAO.materialGridSiteLoad(session,surtrno,loadid)%>' ;
   } 

 var rendererstring2=function (aggregates){
  	var value=aggregates['sum2'];
  	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "  Total" + '</div>';
  }    



	  var rendererstring1=function (aggregates){
    	var value=aggregates['sum1'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
    }
	  
	  var cellclassname = function (row, column, value, data) {
    		/* if (data.qty==0) {
    			document.getElementById("errormsg").innetText="Quantity Should not Be Zero";
                return "redClass";
            }
    		else{
    			//document.getElementById("errormsg").innetText="";
    		} */
    		};
 
var rendererstring=function (aggregates){
	var value=aggregates['sum'];
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
}
 /* 
            $('#gridtext').keyup(function(){
             	

 			      $("#prosearchGrid").jqxGrid('clearfilters');
       		  
             
                 $('#part_no').val($(this).val());
                 var dataField = "part_no";
          applyFilter(dataField,$(this).val());  
                 
                 
                 
             });
             
         
             $('#gridtext1').keyup(function(){
             	

 			      $("#prosearchGrid").jqxGrid('clearfilters');
     		  
           
               $('#brandname').val($(this).val());
               var dataField = "brandname";
    		   applyFilter(dataField,$(this).val());  
               
               
               
           });            
            
           	  */
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'desc1', type: 'string'  },
							{name : 'product', type: 'string' },
     						{name : 'productid', type: 'string' },
     						{name : 'activity', type: 'string' },
     						{name : 'activityid', type: 'string' },
     						{name : 'brandname', type: 'string'},
     						{name : 'unit', type: 'string'  },
     						{name : 'qty', type: 'number'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'total', type: 'number'  },
     						{name : 'nettotal', type: 'number'  },
     						{name : 'margin', type: 'number'  },
     						{name : 'invoiced', type: 'bool'  },
                    		{name : 'proname', type: 'string'    },
                    		{name : 'prodoc', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						{name : 'proid', type: 'number'    },
     						{name : 'specid', type: 'number'    },  
     						{name : 'stypeid', type: 'number'    },
     						{name : 'site', type: 'string'    },
     						{name : 'sertype', type: 'string'    },
     						{name : 'brandid', type: 'number'    },  
     						{name : 'sitesrno', type: 'number'    },  
     						{name : 'slno', type: 'number'    },   
     						{name : 'stdprice', type: 'number'    },
     						{name : 'marginper', type: 'number'    },
                        ],
                        
                        
                       
                         localdata: matdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            		
            };
            	
            	  $("#materialGrid").on("bindingcomplete", function (event) {
            			
            		  if(document.getElementById("cmbreftype").value=="DIR"){
                      	$('#materialGrid').jqxGrid('setcolumnproperty','site','editable',true);
                                  	
                      }	
            		  else{
            			  $('#materialGrid').jqxGrid('setcolumnproperty','site','editable',false);
            		  }
                    	 var rowlength=$("#materialGrid").jqxGrid('rows').records.length;
                    	 
                    	if(rowlength>0){
                    		var summaryData1= $("#materialGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
                    		
                    		document.getElementById("txtmatotal").value=summaryData1.sum.replace(/,/g,''); 
                    		 var txtmatotal=document.getElementById("txtmatotal").value;
                       		
                       		 var grtotal=(parseFloat(txtmatotal));
                       		 document.getElementById("txtnettotal").value=grtotal;
                       		
                   
            		 }
                       }); 
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#materialGrid").jqxGrid(
            {
                width: '99.5%',
                height: 300,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                disabled:true,
                statusbarheight: 21,
                selectionmode: 'singlecell',
                pagermode: 'default',
                handlekeyboardnavigation: function (event) {

                    var cell4 = $('#materialGrid').jqxGrid('getselectedcell');
                   
                    
                    if (cell4 != undefined && (cell4.datafield == 'productid' || cell4.datafield == 'brandname'  )) 
                    
                   {	 
                   	 
                   	 
                   	 
  	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
  	                 
  	                  if (key == 9) { 
  	                	  
  	                	$('#sidesearchwndow').jqxWindow('close');
  	                	  
  	             	   
	   	               	 var rows = $("#prosearchGrid").jqxGrid('getrows');  
  	                	  
  	                	  
  	                   var prodocs=rows[0].doc_no;
  	                
  	                if(parseInt(rows[0].method)==0)
  	              	  {
  	              	  
  	            		var rows1 = $("#materialGrid").jqxGrid('getrows');
  	          	    var aa=0;
  	          	    for(var i=0;i<rows1.length;i++){
  	          	 
  	          	    	
  	          	    	 
  	          		   if(parseInt(rows1[i].prodoc)==parseInt(prodocs))
  	          			   {
  	          			   aa=1;
  	          			   break;
  	          			   }
  	          		   else{
  	          			   
  	          			   aa=0;
  	          		       } 

  	          	 
  	          	   
  	          	                         }
  	          	   
  	          	   
  	          	   
  	          	   if(parseInt(aa)==1)
  	          		   {
  	          		   
  	          			document.getElementById("errormsg").innerText="You have already select this product";
  	          		   
  	          		   return 0;
  	          		   
  	          		   }
  	          	   else
  	          		   {
  	          		   document.getElementById("errormsg").innerText="";
  	          		   }
  	          	   
  	            	  
  	            	  }
  	                	  
  	                	  
  	                	  
  	     
  	                	  
  	                	   
  	               	 var rows = $("#prosearchGrid").jqxGrid('getrows');
  	  		    
  	                	
  	                	   $('#materialGrid').jqxGrid('render');
  	              	  var rowindex1 =$('#rowindex').val();
  	              	  $('#datas1').val("0");
  	               $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
  	               $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].brandname);
  	                $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
  	                $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,rows[0].brandname);
  	                $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,	rows[0].doc_no);
  	                $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
  	                $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].unitdocno);
  	                $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno ); 
  	              $('#materialGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid ); 
  	            $('#datas1').val("1");
  	        //  $("#materialGrid").jqxGrid('begincelledit', rowindex1, 'qty');
  	        
  	       
  	             $('#sidesearchwndow').jqxWindow('close'); 
  	                	   
  	          var rows = $('#materialGrid').jqxGrid('getrows');
               var rowlength= rows.length;
               if(rowindex1 == rowlength - 1)
               	{  
               $("#materialGrid").jqxGrid('addrow', null, {});
               	} 
  	        	            } 
  	                   
  	          $("#materialGrid").jqxGrid('ensurerowvisible', rowlength);
            if (cell4 != undefined && cell4.datafield == 'productid') {
       
       		 
       		   document.getElementById("gridtext").focus();
       		 
            }
            if (cell4 != undefined && cell4.datafield == 'brandname') {
    	        
       		 
       		   document.getElementById("gridtext1").focus();
       		 
          }
              
            
                   } 
       		 
            
                    },
                
                columns: [
							{ text: 'Sr. No.', datafield: 'slno', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Site', datafield: 'site', width: '10%',editable:false },
							{text: 'Service Type', datafield: 'sertype', width: '10%',editable:false },
							{ text: 'Description', datafield: 'desc1', width: '18%',editable:true },
							{ text: 'Product', datafield: 'productid', width: '8%',cellclassname: cellclassname,editable:false
	                          	  
  							    /* createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							     
  							         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"   />' ); 
  							   
  							        
  							    },  */ 
  							 
							},
  							 
{ text: 'Brand', datafield: 'brandname', width: '12%'  ,cellclassname: cellclassname ,editable:false
								

  								
  								/* createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							       
  							         editor.html('<input type="text" id="brandname" name="brandname" style="width:100%;height:99%;"   />' ); 
  							     
  							        
  							    },   */
							
							},
							
							{ text: 'Unit', datafield: 'unit', width: '4%',editable:false,cellclassname: cellclassname },	
							{ text: 'Quantity', datafield: 'qty', width: '4%',cellclassname: cellclassname, cellsformat: 'd2' },
							{ text: 'Amount', datafield: 'amount', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname },
							{ text: 'Total', datafield: 'total', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname },
							{ text: 'Margin %', datafield: 'marginper', width: '4%',cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right' , align: 'right'},
							{ text: 'Margin', datafield: 'margin', width: '4%',cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Net Total', datafield: 'nettotal', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname},
							{text: 'pid', datafield: 'proid', width: '10%',cellclassname: cellclassname,hidden:true }, 
  							{text: 'pname', datafield: 'proname', width: '10%',cellclassname: cellclassname,hidden:true },
  							{text: 'prodoc', datafield: 'prodoc', width: '10%',cellclassname: cellclassname,hidden: true},
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'specid', datafield: 'specid', width: '10%',cellclassname: cellclassname,hidden:true}, 
							{text: 'brandid', datafield: 'brandid', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'stypeid', datafield: 'stypeid', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'sitesrno', datafield: 'sitesrno', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'stdprice', datafield: 'stdprice', width: '10%',cellclassname: cellclassname,hidden:true},
							/* { text: 'Invoiced', datafield: 'invoiced', columntype: 'checkbox', editable: true, checked: true, width: '5%',cellsalign: 'center', align: 'center' }, */
						]
            });
            
            $('#materialGrid').on('celldoubleclick', function (event) {
               
            	var columnindex1=event.args.columnindex;
            	 var datafield=event.args.datafield;
                        	  if(datafield == "productid")
            		  { 
                	 productSearchContent('productMasterSearch.jsp');
            	 var rowindextemp = event.args.rowindex;
            	    document.getElementById("rowindex").value = rowindextemp;  
            	    
  
            
               
            		  } 
            	  
            	  
            	   if(datafield == "brandname")
        		  { 
            		productSearchContent('productMasterSearch.jsp');
        	 var rowindextemp = event.args.rowindex;
        	    document.getElementById("rowindex").value = rowindextemp;  
        		  
            } 	 
                   
            	   if(datafield=="unit")
    	    	   {
            		   var rowindextemp = event.args.rowindex;
    	    	  unitSearchContent('unitSearchGrid.jsp?rowno='+rowindextemp);
    	    	  document.getElementById("rowindex").value = rowindextemp;  
    	    	   }
            	   
            	   
                   });
            
            
            
            function valchange(rowBoundIndex,datafield)
            {
            	//	 var summaryData1= $("#materialGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
            		var summaryData= $("#materialGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
	        	//	var summaryData2= $("#materialGrid").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
        			
     //      document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
       //   document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
          document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
         // document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
            	   }
            
            
            
            $("#materialGrid").on('cellvaluechanged', function (event) 
                    {
            	
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		    var discount=0;
    		    var margin=0;  
    		    var total=0;
    		    var qty=0;
    		    var amount=0;
    		    var nettotal=0;
    		    if(datafield=="desc1"){
    		    	var rowIndex=event.args.rowindex;
    		    	var rows = $('#materialGrid').jqxGrid('getrows');
                    
                    var rowlength= rows.length;
                    if(rowIndex == rowlength - 1)
                    	{  
                    $("#materialGrid").jqxGrid('addrow', null, {});
                    	}
    		    	
    		    	
    		    }
    		    if(parseInt($('#datas').val())!=1) {
    	            
    	              if(datafield=="productid") {
    	            $('#materialGrid').jqxGrid('setcellvalue', rowBoundIndex, "productid" ,$('#materialGrid').jqxGrid('getcellvalue', rowBoundIndex, "proid"));
    	               $('#sidesearchwndow').jqxWindow('close');
    	             }
    	            
    	              if(datafield=="brandname") {
    	               $('#materialGrid').jqxGrid('setcellvalue', rowBoundIndex, "brandname" ,$('#materialGrid').jqxGrid('getcellvalue', rowBoundIndex, "proname"));
    	                     $('#sidesearchwndow').jqxWindow('close');
    	             }
    	            
    	            }
    		    
    		    
    		    if(datafield=="qty" || datafield=="amount" || datafield=='margin' || datafield=="marginper" )
		    		  {
		    		    	
		    		    qty= $('#materialGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
		               	amount= $('#materialGrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");
		               	total=$('#materialGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
		     			margin=$('#materialGrid').jqxGrid('getcellvalue', rowBoundIndex, "margin");
		     			
		     			
		     			if(( margin=="" || typeof(margin)=="undefined" || typeof(margin)=="NaN" ))
			       		   {
				    		 margin=0;
			       		   }
		     			var marginper=$('#materialGrid').jqxGrid('getcellvalue', rowBoundIndex, "marginper");
		     			if(marginper==""||marginper==null||marginper=="undefiend" || marginper==0)
						{
							 $('#materialGrid').jqxGrid('setcellvalue', rowBoundIndex, "margin",0);
							 marginper=0;
						}
		     			
						
		    		    	if(!(qty==""||typeof(qty)=="undefined"|| typeof(qty)=="NaN" || amount=="" || typeof(amount)=="undefined" || typeof(amount)=="NaN"))
		           		   {
		    		    		total=parseFloat(qty)*parseFloat(amount);
		    		    		nettotal=total;
		    		    		margin=(parseFloat(nettotal)*parseFloat(marginper))/100;
		    		    		discount=parseFloat(margin);
		            			nettotal=parseFloat(total)+parseFloat(discount);
		         //   alert("margin "+margin+"nettotal "+nettotal);
		             			$('#materialGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
		             			// $('#materialGrid').jqxGrid('setcellvalue', rowBoundIndex, "marginper",margin);
		             			$('#materialGrid').jqxGrid('setcellvalue', rowBoundIndex, "margin",margin);
		             			$('#materialGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",nettotal);
		             			
		           		   }
		    		    	
			     			
		    		  
		    		  }
    		
    			
        		if(datafield=="marginper"){
        			var marginper=$('#materialGrid').jqxGrid('getcellvalue', rowBoundIndex, "marginper");
        			var totals=$('#materialGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
						if(marginper==""||marginper==null||marginper=="undefiend" || marginper==0)
							{
						 
						 $('#materialGrid').jqxGrid('setcellvalue', rowBoundIndex, "margin",0);
						
							}
						else{
							
							var	marginval=(parseFloat(totals)*parseFloat(marginper))/100;
							
					   		 $('#materialGrid').jqxGrid('setcellvalue', rowBoundIndex, "margin",marginval);
					 
						}	
        }
    		
        		if(datafield=="margin"){
        			var marginper=$('#materialGrid').jqxGrid('getcellvalue', rowBoundIndex, "marginper");
        			var margin=$('#materialGrid').jqxGrid('getcellvalue', rowBoundIndex, "margin");
        			var totals=$('#materialGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
        			if(margin==""||margin==null||margin=="undefiend" || margin==0)
        				{
		        				if(marginper==""||marginper==null||marginper=="undefiend" || marginper==0)
		        				{
		        			 
		        			 $('#materialGrid').jqxGrid('setcellvalue', rowBoundIndex, "margin",0);
		        			 $('#materialGrid').jqxGrid('setcellvalue', rowBoundIndex, "marginper",0);
		        				}
		        			else{
		        				
		        				var	marginval=(parseFloat(totals)*parseFloat(marginper))/100;
		        				
		        		   		 $('#materialGrid').jqxGrid('setcellvalue', rowBoundIndex, "margin",marginval);
		        		 
		        			}	
        				}
        			else{
        				/* if(marginper==""||marginper==null||marginper=="undefiend" || marginper==0)
        				{ */
        					var	marginp=(parseFloat(margin)*100)/parseFloat(total);
            				
           		   		 $('#materialGrid').jqxGrid('setcellvalue', rowBoundIndex, "marginper",marginp);
        			
        				/* }
        			else{
        				// $('#materialGrid').jqxGrid('setcellvalue', rowBoundIndex, "margin",0);
            			// $('#materialGrid').jqxGrid('setcellvalue', rowBoundIndex, "marginper",0);
        				
        		 
        			}	 */
        				
        			}
		
        }
        		
        		
    		     var summaryData1= $("#materialGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
        		document.getElementById("txtmatotal").value=summaryData1.sum.replace(/,/g,''); 
        		
        		
        		 var txtmatotal=document.getElementById("txtmatotal").value;
           		
           		 var grtotal=(parseFloat(txtmatotal));
           		 document.getElementById("txtnettotal").value=grtotal.toFixed(2);
           		
                   
            	
                    });
            
            
/*             var applyFilter = function (datafield,value) {
                
            	 if(parseInt($('#datas').val())!=1) {
                var filtertype = 'stringfilter';
              
              
                if (datafield == 'part_no' || datafield == 'brandname') filtertype = 'stringfilter';
                var filtergroup = new $.jqx.filter();
         
                    var filter_or_operator = 1;

                    var filtervalue = value;
    	            var filtercondition = 'starts_with';
                    
                    var filter = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
                    filtergroup.addfilter(filter_or_operator, filter);
               
                
                if (datafield == 'part_no') 
                	{
               
                $("#prosearchGrid").jqxGrid('addfilter', 'part_no' , filtergroup);
                //document.getElementById("part_no").focus();
                	}
                else  if (datafield == 'brandname') 
            	         {
                    
                    $("#prosearchGrid").jqxGrid('addfilter', 'brandname' , filtergroup);
                   // document.getElementById("brandname").focus();
                    	}
                
                
           
                $("#prosearchGrid").jqxGrid('applyfilters');
            	 }
          } */
            
            if($('#mode').val()!="view"){
            	$("#materialGrid").jqxGrid('disabled', false);
            }
            
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#materialGrid").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#materialGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#materialGrid").offset();
                       $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#materialGrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#materialGrid").jqxGrid('getrowid', rowindex);
                      
                       $("#materialGrid").jqxGrid('deleterow', rowid);
                   }
               });
               
               $("#materialGrid").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                       $("#materialGrid").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   }
        		   }
               });
                
              
               $('#materialGrid').on('celldoubleclick', function(event) 
               		{
               	var rowBoundIndex = event.args.rowindex;
               	var datafield = event.args.datafield;
               	 
    		      if((datafield=="sertype"))
   	    	   {
    		    	getservicetype(rowBoundIndex);
   	    	   } 
    		      if(document.getElementById("cmbreftype").value!="DIR"){
    		      if((datafield=="site"))
      	    	   {
    		    	  var surtrno=document.getElementById("hidsurtrno").value;
    		    	  var enqtrno=document.getElementById("hidenqtrno").value;
    		    	  var id=0;
    		    	
    		    	  if(surtrno>0){
    		    		 id=4;
    		    		  getsite(rowBoundIndex,surtrno,id);
    		    	  }
    		    	  else {
    		    		  id=3;
    		    		  getsite(rowBoundIndex,enqtrno,id);
    		    		  }
       		    	
      	    	   } 
    		      }
               			
               		});
               var cmb=document.getElementById("cmbreftype").value;
               if(loadid==3 && enqtrno>0 || loadid==4 && surtrno>0 || cmb=="SRVE")
            	   {
            	   $("#materialGrid").jqxGrid('addrow', null, {});
            	   }
               
        });
</script>
<div id='jqxWidget'>
   <div id="materialGrid"></div>
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">
