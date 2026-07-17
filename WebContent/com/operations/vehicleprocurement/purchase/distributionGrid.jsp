<%@page import="com.operations.vehicleprocurement.purchase.ClsvehpurchaseDAO" %>
<% ClsvehpurchaseDAO vd=new ClsvehpurchaseDAO();%>
<%@page import="javax.servlet.http.HttpServletRequest" %> 
<%@page import="javax.servlet.http.HttpSession" %>
<%-- <% 
String startdate1 = request.getParameter("startdate")==null?"0":request.getParameter("startdate"); 
String cmbfrequency1 = request.getParameter("cmbfrequency")==null?"0":request.getParameter("cmbfrequency");
String amount1 = request.getParameter("amount")==null?"0":request.getParameter("amount");
String instno1 = request.getParameter("instno")==null?"0":request.getParameter("instno");
String instamt1 = request.getParameter("instamt")==null?"0":request.getParameter("instamt");
String dueafter1 = request.getParameter("dueafter")==null?"0":request.getParameter("dueafter");
String tranId = request.getParameter("tranId")==null?"0":request.getParameter("tranId");
%> --%>

<%
String masterdoc = request.getParameter("docnos")==null?"0":request.getParameter("docnos").trim();
String detval = request.getParameter("detval")==null?"0":request.getParameter("detval");



String documentNo = request.getParameter("docNo")==null?"NA":request.getParameter("docNo");

//System.out.println("----------documentNo----"+documentNo);


%>
<style type="text/css">
        .disableClass{
            color: #999;
        }
</style>
<script type="text/javascript">
        
        //var data3;  
        $(document).ready(function () { 
        	
            var temp2='<%=detval%>';
            
            var temp1='<%=documentNo%>';
            
          var temp="";
          
             if(temp1!='NA')
            	 {
            	 
            	 var data3='<%=vd.exportdescription(documentNo) %>';  	 
            	 }
          
          
             else if(parseInt(temp2)==10)  
            	  {
                var data3='<%=vd.description(masterdoc) %>';
                temp=0;
            	  }
              else
            	  {
            	  var data3;  
            	  temp=1;
            	  
            	  } 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                            {name : 'sr_no', type: 'int'  }, 
     						{name : 'date', type: 'string'   },
     						{name : 'chqno', type: 'string'   },
     						{name : 'priamount', type: 'number'  },
     						{name : 'interest', type: 'number'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'bpvno', type: 'number'  }
                        ],
                		  localdata: data3, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
    /*         $("#jqxDistributionGrid").on("bindingcomplete", function (event) {
            	
            	
            	var aa=$('#vehoredergrid').jqxGrid('getcellvalue', 0, "priamount");
            	alert(aa);
            	if(aa>0)
            		{
            	
                var summaryData= $("#vehoredergrid").jqxGrid('getcolumnaggregateddata', 'priamount', ['sum'],true);
                var summaryData1= $("#vehoredergrid").jqxGrid('getcolumnaggregateddata', 'interest', ['sum'],true);
                var summaryData2= $("#vehoredergrid").jqxGrid('getcolumnaggregateddata', 'amount', ['sum'],true);
                
                document.getElementById("prinamtval").value=summaryData.sum; 
                document.getElementById("intamount").value=summaryData1.sum; 
                document.getElementById("totamount").value=summaryData2.sum; 
     
            		}
            
            
            });    */
            
            
   
            
            
            var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
               } 
               var rendererstring1=function (aggregates){
                  	var value=aggregates['sum1'];
                  	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
                  }       
            var cellclassname = function (row, column, value, data) {
               
            }; 
//
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxDistributionGrid").jqxGrid(
            {
                width: '100%',
                height: 400,
                source: dataAdapter,
                editable: true,
                showaggregates:true,
                showstatusbar:true,
              //  disabled:true,
                statusbarheight: 20,
                localization: {thousandsSeparator: ""},
                rowsheight:20,
                selectionmode: 'singlecell', 
                
                columns: [
							{ text: 'Sr. No.', datafield: 'sr_no',  width: '5%', cellsalign: 'center', align: 'center', editable: false, cellclassname: cellclassname},
							{ text: 'Date', datafield: 'date',  width: '15%',  cellclassname: cellclassname, editable: false},
							{ text: 'Cheque No', datafield: 'chqno',  width: '18%',   cellclassname: cellclassname,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 ,
								cellbeginedit: function (row) {
									var payment=document.getElementById("paymentmethod").value;
									var clstatus=document.getElementById("clstatus").value;
									
								  if(parseInt(payment)==2 || parseInt(clstatus)==1 )
									  {
									       return false;
										 }
								    
								  }	
							},
							{ text: 'Principal Amount', datafield: 'priamount',  width: '16%', cellsformat: 'd2', cellsalign: 'right', align: 'right',  cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring, editable: true,
								cellbeginedit: function (row) {
									 
									var clstatus=document.getElementById("clstatus").value;
									
								  if(parseInt(clstatus)==1 )
									  {
									       return false;
										 }
								    
								  }	},
							{ text: 'Interest', datafield: 'interest',  width: '16%', cellsformat: 'd2', cellsalign: 'right', align: 'right', cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring , editable: false},
							{ text: 'Amount', datafield: 'amount',   width: '18%',cellsformat: 'd2', cellsalign: 'right', align: 'right',  cellclassname: cellclassname ,aggregates: ['sum'],aggregatesrenderer:rendererstring , editable: true},
							{ text: 'Bpv No', datafield: 'bpvno',  width: '12%',  cellclassname: cellclassname, editable: false },
						]
            });
            
            
            
            if(temp1!='NA')
           	 {
            	
                var summaryData1= $("#jqxDistributionGrid").jqxGrid('getcolumnaggregateddata', 'priamount', ['sum'],true);
                 
                  document.getElementById("priamounts").value=summaryData1.sum.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
            	
           	 }
          //Add empty row
                   
              if(parseInt(temp2)==10)  
            	  {
            	//  $("#jqxDistributionGrid").jqxGrid({ disabled: false});
                   } 
          
              else if(parseInt(temp)==1)
            	  {
            	  $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
            	  } 
              else
            	  {
            	  
            	  }
          
          
              $("#jqxDistributionGrid").on('cellvaluechanged', function (event) 
                      {
                      	var datafield = event.args.datafield;
                  		
              		    var rowBoundIndex = event.args.rowindex;
              	 
              		     
                      		if(datafield=="priamount")
                      		    {
                      			document.getElementById("errormsg").innerText="";
                      			valchange(rowBoundIndex);
                      		    }
			if(datafield=="amount")
                      		{
				  var perint=document.getElementById("perinterest").value;
            	    var instnos=document.getElementById("instnos").value;
            	  
            	var amount=$('#jqxDistributionGrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");
            	
            	/*    var priamount=(parseFloat(loanval)/(parseFloat(instnos))); 
		            var interest=(((((parseFloat(loanval)*parseFloat(perint)/100))*(parseFloat(instnos)/12)))/(parseFloat(instnos))); 
            	 */
		           // var interest=parseFloat(priamount)*(parseFloat(perint)/100)*(parseFloat(instnos)/12); 
var priamount=0;
			priamount=(parseFloat(amount)/ ( 1 + ( parseFloat(perint)/100)*(parseFloat(instnos)/12)));
//				select (7840/ (1+ ( 4 /100*(36/12))) );
	
					 var interest=parseFloat(amount)-parseFloat(priamount);
              
					$('#jqxDistributionGrid').jqxGrid('setcellvalue',rowBoundIndex, "interest" ,interest );
					$('#jqxDistributionGrid').jqxGrid('setcellvalue',rowBoundIndex, "priamount" ,priamount); 
      	                   
      	                   var summaryData1= $("#jqxDistributionGrid").jqxGrid('getcolumnaggregateddata', 'priamount', ['sum'],true);
     	                    
      	                   document.getElementById("priamounts").value=summaryData1.sum.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");

				}
                      	
                      		});
          
              function valchange(rowBoundIndex)
              {
            	  var perint=document.getElementById("perinterest").value;
            	    var instnos=document.getElementById("instnos").value;
            	  
            	var priamount=$('#jqxDistributionGrid').jqxGrid('getcellvalue', rowBoundIndex, "priamount");
            	
            	/*    var priamount=(parseFloat(loanval)/(parseFloat(instnos))); 
		            var interest=(((((parseFloat(loanval)*parseFloat(perint)/100))*(parseFloat(instnos)/12)))/(parseFloat(instnos))); 
            	 */
		            var interest=parseFloat(priamount)*(parseFloat(perint)/100)*(parseFloat(instnos)/12); 

					
					 var amount=parseFloat(priamount)+parseFloat(interest);
              
					$('#jqxDistributionGrid').jqxGrid('setcellvalue',rowBoundIndex, "interest" ,interest );
					$('#jqxDistributionGrid').jqxGrid('setcellvalue',rowBoundIndex, "amount" ,amount); 
      	                   
      	                   var summaryData1= $("#jqxDistributionGrid").jqxGrid('getcolumnaggregateddata', 'priamount', ['sum'],true);
     	                    
      	                   document.getElementById("priamounts").value=summaryData1.sum.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
      	                  
      	                   
      	      
      		    
              }
   
        });
    </script>
    <div id="jqxDistributionGrid"></div>
 