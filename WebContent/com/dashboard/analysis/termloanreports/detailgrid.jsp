<%@page import="com.dashboard.analysis.termloanreports.ClsTermLoanReportsDAO" %>
<%ClsTermLoanReportsDAO prchdao=new ClsTermLoanReportsDAO(); %>

<%-- <%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String fleetNo = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno").trim();
     String group = request.getParameter("group")==null?"0":request.getParameter("group").trim();
     String model = request.getParameter("model")==null?"0":request.getParameter("model").trim();
     String rptType = request.getParameter("rpttype")==null?"0":request.getParameter("rpttype");
     String check = request.getParameter("check")==null?"0":request.getParameter("check");%>  --%>

<% 
String branchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");
 String type = request.getParameter("type")==null?"NA":request.getParameter("type");
 
 String val = request.getParameter("val")==null?"NA":request.getParameter("val");
 

 String findoc = request.getParameter("findoc")==null?"NA":request.getParameter("findoc"); 
 String dealno = request.getParameter("dealno")==null?"NA":request.getParameter("dealno");
 String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
 
 
 %>
<style type="text/css">
  .opnClass
  {
      color: #298A08;
  }
  .additionClass
  {
      color: #0101DF;
  }
  .deletionClass
  {
     color: #FF0000;
  }
  
   .opnClass
  {
      color: #298A08;
  }
  .valClass
  {
      color: #8a2be2;
  }
  .downClass
  {
     color: #c71585;
  }
  
  
    .paidClass
  {
      color: #191970;
  }
  .notpaidClass
  {
     color: #b22222;
  }
  
  
  
   
  
</style>
<script type="text/javascript">
      var datasss;
   var temp='<%=val%>';
     

	 
	  	if(temp=="fleets"){ 
	  		
	  	  detaildata ='<%=prchdao.searchexceldetailsdata(branchval,type,findoc,dealno,upToDate)%>';
	  			
	  	  datasss ='<%=prchdao.searchdetailsdata(branchval,type,findoc,dealno,upToDate)%>';
	  	
	  	}
  	
        $(document).ready(function () {
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'dealno' , type: 'String' }, 
     						{name : 'financiername', type: 'String'  },
     						{name : 'account',type:'String'},
     						
     						{name : 'interest',type:'number'},
     						{name : 'principle',type:'number'},
     						{name : 'pytvalue', type: 'number'  },
     						
     						
     						{name : 'interest1',type:'number'},
     						{name : 'principle1',type:'number'},
     						{name : 'pytvalue1', type: 'number'  },
     						
     						
     						{name : 'interest2',type:'number'},
     						{name : 'principle2',type:'number'},
     						{name : 'pytvalue2', type: 'number'  },
     						
     						
     						{name : 'stdate',type:'date'},
     						{name : 'enddate',type:'date'},
     						{name : 'totalval', type: 'number'  },
     						
     						{name : 'dwnpyt', type: 'number'  },
     	     				
     						{name : 'intst', type: 'number'  },
     						
     						{name : 'chqdate',type:'date'},
     						{name : 'chqname',type:'String'},
     						{name : 'sectychqno',type:'String'},
     						{name : 'paid',type:'String'},
     						
     						{name : 'bpvno',type:'number'},
     						//paid, chqdate, chqname, sectychqno, doc_no, stdate, enddate, totalval, dwnpyt, intst, dealno, financiername, account, interest, principle, pytvalue, interest1, principle1, pytvalue1, interest2, principle2, pytvalue2
     	     				
     				
     						
	                      ],
                          localdata: datasss,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var cellclassname =  function (row, column, value, data) {


            	  var ss= $('#detailgeids').jqxGrid('getcellvalue', row, "bpvno");
            		          if(parseInt(ss)>0)
            		  		{
            		  		
            		  		return "paidClass";
            		
            		  		}
            		          else
            		          {
            		        	  
            		
            		        	  
            		        		return "notpaidClass";  
            		        	  
            		          }
            	    
            	    	/* return "greyClass";
            	    	
            		        var element = $(defaultHtml);
            		        element.css({ 'background-color': '#F3F297', 'width': '100%', 'height': '100%', 'margin': '0px' });
            		        return element[0].outerHTML;
            	*/

            		}
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#detailgeids").jqxGrid(
            {
                width: '98%',
                height: 530,
                source: dataAdapter,
                rowsheight:25,
                statusbarheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                showaggregates: true,
             	showstatusbar:true,
                editable: false,
                
                columns: [
							{ text: 'No.', sortable: false, filterable: false, editable: false,
						    	groupable: false, draggable: false, resizable: false,datafield: '',
						    	columntype: 'number', width: '3%',cellsalign: 'center', align: 'center',
						    	cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						      }    
							},
							
						
     						
     						{ text: 'Deal No', datafield: 'dealno',editable:false, width: '5%'},
							{ text: 'Financier Name', datafield: 'financiername',editable:false, width: '12%'},
							{ text: 'Account', datafield: 'account',editable:false, width: '6%' },
							

							//stdate, , , dwnpyt, intst,
							
							{ text: 'Start Date', datafield: 'stdate',editable:false, width: '6%',cellsformat:'dd.MM.yyyy'},
							{ text: 'End Date', datafield: 'enddate',editable:false, width: '6%',cellsformat:'dd.MM.yyyy',aggregates: ['sum1'],aggregatesrenderer:rendererstring1}, 
						/* 	{ text: 'Value', datafield: 'totalval',editable:false, width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: 'valClass',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							
							{ text: 'Down Pyt', datafield: 'dwnpyt',editable:false, width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: 'downClass',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: ' % Interest', datafield: 'intst',editable:false, width: '8%',cellsformat:'d2',cellsalign:'right',align:'right'},
							 */
													
							{ text: 'Cheque Date', datafield: 'chqdate',editable:false, width: '6%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Cheque Name', datafield: 'chqname',editable:false, width: '15%' },
							{ text: 'Cheque NO', datafield: 'sectychqno',editable:false, width: '11%' },
							{ text: 'Status', datafield: 'paid',editable:false, width: '6%',cellclassname:cellclassname },
							
							
							{ text: 'Interest', datafield: 'interest', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'fin',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'opnClass' },
							{ text: 'Principle', datafield: 'principle', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'fin',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'additionClass' },
							{ text: 'value',datafield:'pytvalue', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'fin',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: 'deletionClass' },
							
							{ text: 'Interest', datafield: 'interest1', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'paid',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'opnClass' },
							{ text: 'Principle', datafield: 'principle1', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'paid',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'additionClass' },
							{ text: 'value',datafield:'pytvalue1', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'paid',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: 'deletionClass' },
							
							{ text: 'Interest', datafield: 'interest2', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'bal',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'opnClass' },
							{ text: 'Principle', datafield: 'principle2', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'bal',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'additionClass' },
							{ text: 'value',datafield:'pytvalue2', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'bal',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: 'deletionClass' },
							
						
							],
							columngroups: 
							  [
							    { text: 'Finance Taken', align: 'center', name: 'fin',width: '20%' },
							    { text: 'Paid ', align: 'center', name: 'paid',width: '20%' },
							    
							    { text: 'Balance', align: 'center', name: 'bal',width: '20%' }
							 
							  ]
            });
            
           if(temp=='NA'){ 
                $("#detailgeids").jqxGrid("addrow", null, {});
            } 

			$("#overlay, #PleaseWait").hide();
			

        });

</script>
<div id="detailgeids"></div>
