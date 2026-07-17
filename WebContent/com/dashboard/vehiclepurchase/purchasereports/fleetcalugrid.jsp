<%@page import="com.dashboard.vehiclepurchase.purchasereports.ClsPurchaseReportsDAO"%>

<% 
String branchval = request.getParameter("barchvals")==null?"NA":request.getParameter("barchvals");

 
 String val = request.getParameter("vals")==null?"NA":request.getParameter("vals");
 String type = request.getParameter("type")==null?"NA":request.getParameter("type");
 
 String fleetno = request.getParameter("fleetno")==null?"NA":request.getParameter("fleetno");
 
 String findoc = request.getParameter("findoc")==null?"NA":request.getParameter("findoc"); 
 String dealno = request.getParameter("dealno")==null?"NA":request.getParameter("dealno");
 String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
 
// System.out.println("----val---------"+val);

ClsPurchaseReportsDAO prchdao= new ClsPurchaseReportsDAO();

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
</style>
<script type="text/javascript">
      var fleetdata;
   var temp='<%=val%>';
     
	
	 
	  	if(temp=="fleet"){ 
	  		
	  		
	  		
	  		
	  		fleetexceldata ='<%=prchdao.fleetexceldetails(branchval,fleetno,findoc,dealno, upToDate)%>';
	  		
	  		fleetdata ='<%=prchdao.fleetdetails(branchval,fleetno,findoc,dealno, upToDate)%>'; 
	  		
	  		
	  		//alert(fleetdata);
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
                             
                     		{name : 'fleet_no' , type: 'String' }, 
     						{name : 'flname', type: 'String'  },
     						{name : 'reg_no',type:'String'},
     
							{name : 'dealno' , type: 'String' }, 
     						{name : 'financiername', type: 'String'  },
     						{name : 'account',type:'String'},
     						
     						{name : 'purchaseval',type:'number'},
     						{name : 'amountbal',type:'number'},
     						
     			/* 			{name : 'interest',type:'number'},
     						{name : 'principle',type:'number'},
     						{name : 'pytvalue', type: 'number'  },
     						
     						
     						{name : 'interest1',type:'number'},
     						{name : 'principle1',type:'number'},
     						{name : 'pytvalue1', type: 'number'  },
     						
     						
     						{name : 'interest2',type:'number'},
     						{name : 'principle2',type:'number'},
     						{name : 'pytvalue2', type: 'number'  }, */
     				
     						
	                      ],
                          localdata: fleetdata,
               
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
            $("#fleeetgrid").jqxGrid(
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
						    	columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
						    	cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						      }    
							},
							
					
     						{ text: 'Fleet No', datafield: 'fleet_no',editable:false, width: '10%'},
							{ text: 'Fleet Name', datafield: 'flname',editable:false, width: '15%'},
     						{ text: 'Reg No', datafield: 'reg_no',editable:false, width: '10%'},
     						{ text: 'Deal No', datafield: 'dealno',editable:false, width: '9%'},
							{ text: 'Financier Name', datafield: 'financiername',editable:false, width: '18%'},
							{ text: 'Account', datafield: 'account',editable:false, width: '10%',aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
							
							{ text: 'Purchase Value', datafield: 'purchaseval', width: '12%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'opnClass' },
							{ text: 'Balance Amount ', datafield: 'amountbal', width: '12%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'additionClass' },
							
						/* 	
							{ text: 'Interest', datafield: 'interest', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'fin',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'opnClass' },
							{ text: 'Principle', datafield: 'principle', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'fin',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'additionClass' },
							{ text: 'value',datafield:'pytvalue', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'fin',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: 'deletionClass' },
							
							{ text: 'Interest', datafield: 'interest1', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'paid',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'opnClass' },
							{ text: 'Principle', datafield: 'principle1', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'paid',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'additionClass' },
							{ text: 'value',datafield:'pytvalue1', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'paid',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: 'deletionClass' },
							
							{ text: 'Interest', datafield: 'interest2', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'bal',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'opnClass' },
							{ text: 'Principle', datafield: 'principle2', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'bal',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'additionClass' },
							{ text: 'value',datafield:'pytvalue2', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'bal',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: 'deletionClass' },
							 */
					
							],
							
            });
            
           if(temp=='NA'){ 
                $("#fleeetgrid").jqxGrid("addrow", null, {});
            } 

			$("#overlay, #PleaseWait").hide();
			

        });

</script>
<div id="fleeetgrid"></div>
