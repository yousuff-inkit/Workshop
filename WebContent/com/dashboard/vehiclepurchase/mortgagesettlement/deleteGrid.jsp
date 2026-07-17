<%@page import="com.dashboard.vehiclepurchase.mortgagesettlement.*" %>
<%
ClsMortgageSettlementDAO mortdao=new ClsMortgageSettlementDAO();
String purchasedocno=request.getParameter("purchasedocno")==null?"":request.getParameter("purchasedocno");
String id=request.getParameter("id")==null?"":request.getParameter("id");%>
<script type="text/javascript">
var id='<%=id%>';
var deletedata=[];
if(id=="1"){
	deletedata='<%=mortdao.getDeleteData(purchasedocno,id)%>';
}
$(document).ready(function () { 	

    var rendererstring=function (aggregates){
    	var value=aggregates['sum'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + '' + value + '</div>';
    }
                    
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                            {name : 'purchasedocno',type:'int'},
                            {name : 'ucrdocno',type:'int'},
                            {name : 'detaildocno',type:'int'},
                            {name : 'date',type:'date'},
     						{name : 'chequeno', type: 'string'  },
     						{name : 'principalamt', type: 'number'    },
     						{name : 'interestamt', type: 'number'    },
     						{name : 'amount', type: 'number'    },
     						{name : 'bpvno', type: 'number'    },
     						{name : 'defaultrow',type:'number'},
     						{name : 'editstatus',type:'number'},
     						{name : 'defaultdeleterow',type:'number'}
                 ],               
               localdata:deletedata,
               
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#deleteGrid").on("bindingcomplete", function (event) {$("#overlay, #PleaseWait").hide();});                 
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#deleteGrid").jqxGrid(
            {
                width: '98%',
                height: 150,
                source: dataAdapter,
                columnsresize: true,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                altRows: true,
                selectionmode: 'singlecell',
               // pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                   
				},
                
                //Filter
                /* ready: function () {
                    addfilter();
                }, */
                
                
                columns: [
                            { text: 'Sr. No.',datafield: '',columntype:'number', width: '5%',editable:false, cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },
                            { text:'Purchase Docno',datafield:'purchasedocno',width:'13.5%'},
                            { text:'UCR Docno',datafield:'ucrdocno',width:'13.5%',hidden:true},
                            { text:'Detail Docno',datafield:'detaildocno',width:'13.5%',hidden:true},
                            {text: 'Date',datafield:'date',width:'13.5%',cellsformat:'dd.MM.yyyy',columntype:'datetimeinput'},					
							{ text: 'Cheque No', datafield: 'chequeno', width: '13.5%' },
							{ text: 'Principal Amount', datafield: 'principalamt', width: '13.5%' ,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Interest Amount', datafield: 'interestamt', width: '13.5%' ,align:'right',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Amount', datafield: 'amount', width: '13.5%' ,align:'right',cellsformat:'d2',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable:false},
							{ text: 'BPV No', datafield: 'bpvno', width: '14%',editable:false},
							{ text: 'Default Row Status', datafield: 'defaultrow', width: '14%',hidden:true,editable:false},
							{ text: 'Edit Row Status', datafield: 'editstatus', width: '14%',hidden:true,editable:false},
							{ text: 'Default Delete Row', datafield: 'defaultdeleterow', width: '14%',hidden:true,editable:false}
	              ]
      });
});
</script>
<div id="deleteGrid"></div>