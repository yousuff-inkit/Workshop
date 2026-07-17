<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.leasecalculator.*" %>
<% String contextPath=request.getContextPath();
ClsLeaseCalculatorDAO calcdao=new ClsLeaseCalculatorDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id"); 
String purchcost=request.getParameter("purchcost")==null || request.getParameter("purchcost").equalsIgnoreCase("")?"0":request.getParameter("purchcost");
String downpytper=request.getParameter("downpytper")==null || request.getParameter("downpytper").equalsIgnoreCase("")?"0":request.getParameter("downpytper");
String interestper=request.getParameter("interestper")==null || request.getParameter("interestper").equalsIgnoreCase("")?"0":request.getParameter("interestper");
String creditper=request.getParameter("creditper")==null || request.getParameter("creditper").equalsIgnoreCase("")?"0":request.getParameter("creditper");
String authority=request.getParameter("authority")==null || request.getParameter("authority").equalsIgnoreCase("")?"0":request.getParameter("authority");
String profitper=request.getParameter("profitper")==null || request.getParameter("profitper").equalsIgnoreCase("")?"0":request.getParameter("profitper");
String overheadper=request.getParameter("overheadper")==null || request.getParameter("overheadper").equalsIgnoreCase("")?"0":request.getParameter("overheadper");
String others=request.getParameter("others")==null || request.getParameter("others").equalsIgnoreCase("")?"0":request.getParameter("others");
String discount=request.getParameter("discount")==null || request.getParameter("discount").equalsIgnoreCase("")?"0":request.getParameter("discount");
String leasemonths=request.getParameter("leasemonths")==null || request.getParameter("leasemonths").equalsIgnoreCase("")?"0":request.getParameter("leasemonths");
String kmpermonth=request.getParameter("kmpermonth")==null || request.getParameter("kmpermonth").equalsIgnoreCase("")?"0":request.getParameter("kmpermonth");
String grpid=request.getParameter("grpid")==null || request.getParameter("grpid").equalsIgnoreCase("")?"0":request.getParameter("grpid");
String authid=request.getParameter("authid")==null || request.getParameter("authid").equalsIgnoreCase("")?"":request.getParameter("authid");
String docno=request.getParameter("docno")==null || request.getParameter("docno").equalsIgnoreCase("")?"":request.getParameter("docno");
String leasereqdocno=request.getParameter("leasereqdocno")==null || request.getParameter("leasereqdocno").equalsIgnoreCase("")?"":request.getParameter("leasereqdocno");
String srno=request.getParameter("srno")==null || request.getParameter("srno").equalsIgnoreCase("")?"":request.getParameter("srno");
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<style>
   .greenClass
        {
           background-color: #F0FFFF;
        }
   .redClass
        {
            background-color: #FFEBEB;
        }
</style>
<script type="text/javascript">
		var id='<%=id%>';
		var data1;
		if(id=="1"){
			data1='<%=calcdao.calculate(purchcost,downpytper,interestper,creditper,authority,profitper,overheadper,others,discount,leasemonths,kmpermonth,grpid,id,authid,srno,docno,leasereqdocno)%>';
		}
		else if(id=="2"){
			data1='<%=calcdao.getCalculateView(docno,leasereqdocno,srno,id)%>';
		}	  
			
		
		<%-- var data1='<%=com.operations.marketing.leasecalculator.ClsLeaseCalculatorDAO.leaseGridLoading()%>'; --%>  
        
		$(document).ready(function() { 
                   
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'details', type: 'string' }, 
     						{name : 'totalamount',type:'number'},
     						{name : 'amount1', type: 'number'   },
     						{name : 'amount2', type: 'number'  },
     						{name : 'amount3', type: 'number'   },
     						{name : 'amount4', type: 'number'   },
     						{name : 'amount5', type: 'number' },
     						{name : 'flow',type:'string'}
                        ],
                         localdata: data1,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var cellclassname = function (row, column, value, data) {
                if(typeof(data.flow)=="undefined" || data.flow=="" || data.flow=="0"){
                	return ""; 
                }
                else if(data.flow=="1") {
                	//alert(data.amount);
                	return "redClass";
                }
                else if(data.flow=="2"){
                	return "greenClass";
                };
                  };
                  
                  

                  $("#jqxleasecalculator").on("bindingcomplete", function (event) {
                  		var rows=$('#jqxleasecalculator').jqxGrid('getrows');
                  		if(rows.length>0){
                  			for(var i=0;i<rows.length-1;i++){
                  				if($('#jqxleasecalculator').jqxGrid('getcellvalue',i,'details')=='Net Rental'){
                  					document.getElementById("totalvalue").value=$('#jqxleasecalculator').jqxGrid('getcellvalue',i,'totalamount');
                  				}
                  			}
                  		}
                  	//$('#rentalInvoiceGrid').jqxGrid({ sortable: true});
                  	});
                  
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxleasecalculator").jqxGrid(
            {
                width: '98%',
                height: 250,
                source: dataAdapter,
  //              editable: true,
                showaggregates: true,
                selectionmode: 'singlerow',
                
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
							{ text: 'Details', datafield: 'details',  width: '25%',cellclassname:cellclassname },	
							{ text: 'Amount', datafield: 'totalamount',  cellsalign: 'right', align: 'right',cellsformat:'d2', width: '12.5%',cellclassname:cellclassname },
							{ text: '1st Year', datafield: 'amount1',  cellsalign: 'right', align: 'right',cellsformat:'d2', width: '12.5%',cellclassname:cellclassname },	
							{ text: '2nd Year', datafield: 'amount2', cellsalign: 'right', align: 'right', cellsformat:'d2',width: '12.5%',cellclassname:cellclassname },
							{ text: '3rd Year', datafield: 'amount3', cellsalign: 'right', align: 'right', cellsformat:'d2',width: '12.5%',cellclassname:cellclassname },
							{ text: '4th Year', datafield: 'amount4',  cellsalign: 'right', align: 'right',cellsformat:'d2', width: '12.5%',cellclassname:cellclassname },
							{ text: '5th Year', datafield: 'amount5', cellsalign: 'right', align: 'right', cellsformat:'d2',width: '12.5%',cellclassname:cellclassname },
							{ text: 'Flow', datafield: 'flow',width: '12.5%',cellclassname:cellclassname,hidden:true },
						]
            });
            
            //Add empty row
         	 /* $("#jqxleasecalculator").jqxGrid('addrow', null, {}); */
         	            
        });
    </script>
    <div id="jqxleasecalculator"></div>
    
