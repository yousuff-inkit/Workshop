<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.leasecalculatoralfahim.*" %>
<% String contextPath=request.getContextPath();
ClsLeaseCalcAlFahimDAO calcdao=new ClsLeaseCalcAlFahimDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id"); 
String typeonearray=request.getParameter("typeonearray")==null?"":request.getParameter("typeonearray");
String kmuse=request.getParameter("kmuse")==null?"":request.getParameter("kmuse");
String reqdocno=request.getParameter("reqdocno")==null?"":request.getParameter("reqdocno");
String reqsrno=request.getParameter("reqsrno")==null?"":request.getParameter("reqsrno");
String calcdocno=request.getParameter("calcdocno")==null?"":request.getParameter("calcdocno");
%>

<script type="text/javascript">
		var id='<%=id%>';
		var typetwodata;
		if(id=="5" && reqdocno!=""){
			typetwodata='<%=calcdao.getTypeDataView(id,reqdocno,"2",reqsrno,calcdocno)%>';
		}
		else if(id=="2"){
			typetwodata='<%=calcdao.processTypetwoGrid(typeonearray,id,kmuse,reqdocno,reqsrno,calcdocno)%>';
		}
		<%-- var data1='<%=com.operations.marketing.leasecalculator.ClsLeaseCalculatorDAO.leaseGridLoading()%>'; --%>  
        
		$(document).ready(function() { 
                   
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'srno',type:'number'},
     						{name : 'description', type: 'string' },
     						{name : 'amount',type:'number'}
                        ],
                         localdata: typetwodata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
          
                  $("#leaseTypetwoGrid").on("bindingcomplete", function (event) {
                	  var id='<%=id%>';
                	  if(id=="2"){
                		  var rows=$('#leaseTypetwoGrid').jqxGrid('getrows');
                    		if(rows.length>0){
                    			for(var i=0;i<rows.length-1;i++){
                    				if($('#leaseTypetwoGrid').jqxGrid('getcellvalue',i,'srno')=='21'){
                    					document.getElementById("residalvalue").value=$('#leaseTypetwoGrid').jqxGrid('getcellvalue',i,'amount');
                    				}
                    			}
                    		}  
                	  }
                  		
                  	//$('#rentalInvoiceGrid').jqxGrid({ sortable: true});
                  	});
                  
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#leaseTypetwoGrid").jqxGrid(
            {
                width: '98%',
                height: 250,
                source: dataAdapter,
                editable: false,
                showaggregates: true,
                selectionmode: 'singlecell',
               /*  localization: {thousandsSeparator: ""}, */
                //Add row method
                handlekeyboardnavigation: function (event) {
/*                 	var rows = $('#jqxleasecalculator').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxleasecalculator').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'fifthyear' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {  
                            var commit = $("#jqxleasecalculator").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }  */
                },
                       
                columns: [
							{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
								groupable: false, draggable: false, resizable: false,datafield: '',
								columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
								cellsrenderer: function (row, column, value) {
									return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
								}
							},
							{ text: 'srnooriginal',datafield:'original',width:'10%',hidden:true},
							{ text: 'Description', datafield: 'description',  width: '60%',editable:false},	
							{ text: 'Amount', datafield: 'amount',  cellsalign: 'right', align: 'right',cellsformat:'d2', width: '30%',editable:true,aggregates: ['sum']}
							
						]
            });
            
            //Add empty row
         	 /* $("#jqxleasecalculator").jqxGrid('addrow', null, {}); */
         	            
        });
    </script>
    <div id="leaseTypetwoGrid"></div>
    
