<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.leasecalculatoralfahim.*" %>
<% String contextPath=request.getContextPath();
ClsLeaseCalcAlFahimDAO calcdao=new ClsLeaseCalcAlFahimDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id"); 
String reqdocno=request.getParameter("reqdocno")==null?"":request.getParameter("reqdocno");
String reqsrno=request.getParameter("reqsrno")==null?"":request.getParameter("reqsrno");
String calcdocno=request.getParameter("calcdocno")==null?"":request.getParameter("calcdocno"); 
%>

<script type="text/javascript">
		var id='<%=id%>';
		var reqdocno='<%=reqdocno%>';
		var reqsrno='<%=reqsrno%>';
		var typeonedata;
		var residualvalue=0.0;
		var convertrate=0.0,exkmrate=0.0;
		var trackervalue=0.0;
		if(id=="5" && reqdocno!=""){
			typeonedata='<%=calcdao.getTypeDataView(id,reqdocno,"1",reqsrno,calcdocno)%>'; 
		}
		else{
			if(reqdocno!="" && reqsrno!=""){
				residualvalue='<%=calcdao.getResidualValue(reqdocno,reqsrno)%>';
				convertrate='<%=calcdao.getConvertRate()%>';
				exkmrate='<%=calcdao.getExKmRate(reqdocno,reqsrno)%>';
				trackervalue='<%=calcdao.getTracker(reqdocno,reqsrno)%>';
			}
			typeonedata='<%=calcdao.getTypeoneData()%>';
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
                         localdata: typeonedata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        

                  $("#leaseTypeoneGrid").on("bindingcomplete", function (event) {
                  		/* var rows=$('#jqxleasecalculator').jqxGrid('getrows');
                  		if(rows.length>0){
                  			for(var i=0;i<rows.length-1;i++){
                  				if($('#jqxleasecalculator').jqxGrid('getcellvalue',i,'details')=='Net Rental'){
                  					document.getElementById("totalvalue").value=$('#jqxleasecalculator').jqxGrid('getcellvalue',i,'totalamount');
                  				}
                  			}
                  		} */
                  	//$('#rentalInvoiceGrid').jqxGrid({ sortable: true});
                  		var id='<%=id%>';
                  		if(id!="5"){
                      		var rows=$('#leaseTypeoneGrid').jqxGrid('getrows');
                    	  	for(var i=0;i<rows.length;i++){
   	                	  		if($('#leaseTypeoneGrid').jqxGrid('getcellvalue',i,'srno')=="20"){
   	            					$('#leaseTypeoneGrid').jqxGrid('setcellvalue',i,'amount',residualvalue);
   	            			  	}
               					if($('#leaseTypeoneGrid').jqxGrid('getcellvalue',i,'srno')=="31"){
                   					$('#leaseTypeoneGrid').jqxGrid('setcellvalue',i,'amount',convertrate);
                   			  	}
               					if($('#leaseTypeoneGrid').jqxGrid('getcellvalue',i,'srno')=="33"){
                   					$('#leaseTypeoneGrid').jqxGrid('setcellvalue',i,'amount',exkmrate);
                   			  	}
               					if($('#leaseTypeoneGrid').jqxGrid('getcellvalue',i,'srno')=="5"){
                   					$('#leaseTypeoneGrid').jqxGrid('setcellvalue',i,'amount',4);
                   			  	}
   								if($('#leaseTypeoneGrid').jqxGrid('getcellvalue',i,'srno')=="34"){
                   					$('#leaseTypeoneGrid').jqxGrid('setcellvalue',i,'amount',trackervalue);
                   			  	}
                		  	}
                  		}
                  	});
                  
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#leaseTypeoneGrid").jqxGrid(
            {
                width: '98%',
                height: 250,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                
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
							{ text:'SrNo from table',datafield:'srno',width:'10%',hidden:true},
							{ text: 'Description', datafield: 'description',  width: '60%',editable:false},	
							{ text: 'Amount', datafield: 'amount',  cellsalign: 'right', align: 'right',cellsformat:'d2', width: '30%',editable:true}
							
						]
            });
            
            //Add empty row
         	 /* $("#jqxleasecalculator").jqxGrid('addrow', null, {}); */
         	            
        });
    </script>
    <div id="leaseTypeoneGrid"></div>
    
