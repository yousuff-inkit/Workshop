<%@page import="com.dashboard.accounts.mainaccountstatement.ClsMainAccountStatementDAO" %>
<%ClsMainAccountStatementDAO DAO=new ClsMainAccountStatementDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String acctype = request.getParameter("acctype")==null?"0":request.getParameter("acctype").trim();
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String chckopening = request.getParameter("chckopening")==null?"0":request.getParameter("chckopening").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%> 
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
      var data;
      var temp='<%=branchval%>';
      var temp1='<%=fromDate%>';
	  var temp2='<%=toDate%>';
	  var temp3='<%=acctype%>';
	  var temp4='<%=chckopening%>';
	  
	  	if(temp!='NA'){ 
	  		   data='<%=DAO.mainaccountStatement(branchval, fromDate, toDate, acctype, accdocno, chckopening,check)%>';
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
							{name : 'acno' , type: 'int' },
							{name : 'account' , type: 'string' },
							{name : 'accountname' , type: 'string' },
							{name : 'currency',type:'string'},
							{name : 'rate' , type:'number'},
							{name : 'dr' , type:'number'},
							{name : 'cr' , type:'number'},
							{name : 'debit' , type:'number'},
							{name : 'credit' , type:'number'}
	                      ],
                          localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	var cellclassname = function (row, column, value, data) {
        		if (data.debit != '') {
                    return "redClass";
                } else if (data.credit != '') {
                    return "yellowClass";
                }
                else{
                	return "greyClass";
                };
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#mainAccountStatement").jqxGrid(
            {
                width: '98%',
                height: 500,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
             	showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:25,
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Account No', datafield: 'acno', hidden: true, width: '5%',columngroup:'cashcontrolaccount' },
							{ text: 'Account', datafield: 'account', cellclassname: cellclassname, width: '11%',columngroup:'cashcontrolaccount' },
							{ text: 'Account Name', datafield: 'accountname', cellclassname: cellclassname,width: '39%',columngroup:'cashcontrolaccount' },
							{ text: 'Currency',  datafield: 'currency',  cellclassname: cellclassname, width: '5%'  ,columngroup:'transactedin'},
							{ text: 'Rate',  datafield: 'rate',  cellclassname: cellclassname, width: '5%',cellsformat: 'd2',columngroup:'transactedin'},
							{ text: 'Dr',  datafield: 'dr',  cellclassname: cellclassname, width: '10%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'transactedin'},
							{ text: 'Cr',  datafield: 'cr',  cellclassname: cellclassname, width: '10%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'transactedin', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Debit',  datafield: 'debit',  cellclassname: cellclassname, width: '10%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'valueinbasecurrency',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Credit',  datafield: 'credit',  cellclassname: cellclassname, width: '10%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'valueinbasecurrency',aggregates: ['sum'],aggregatesrenderer:rendererstring }
						 ], columngroups: 
					                     [
					                       { text: 'Account Informations', align: 'center', name: 'cashcontrolaccount',width: '20%' },
					                       { text: 'Transacted In', align: 'center', name: 'transactedin',width: '10%' },
					                       { text: 'Value In Base Currency', align: 'center', name: 'valueinbasecurrency',width: '10%' }
					                     ]
            });
            
            if(temp=='NA'){
                $("#mainAccountStatement").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
       	   $("#mainAccountStatement").bind('rowselect', function (event) {
       		    var rowindex1 = event.args.rowindex;
       		    var desc= "Main Account Statement"; 
                var accdocno="";
         	    
         	    var url=document.URL;
				var reurl=url.split("com/");
				accdocno=$('#mainAccountStatement').jqxGrid('getcellvalue', rowindex1, "acno");
				var detName=$('#mainAccountStatement').jqxGrid('getcellvalue', rowindex1, "accountname");
				var path="com/dashboard/accounts/mainaccountstatement/detailedAccountStatement.jsp";
				top.addTab( detName,reurl[0]+""+path+"?name="+detName+"&main="+desc+"&branchval="+temp+'&fromdate='+temp1+'&todate='+temp2+'&acctype='+temp3+'&accdocno='+accdocno+'&chckopenings='+temp4);
           	
       		});
              	   
            var debit1="",credit1="",netamount="";
            var debit=$('#mainAccountStatement').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
            debit1=debit.sum;
            var credit=$('#mainAccountStatement').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
            credit1=credit.sum;
            if(!isNaN(debit1 || credit1)){
            	netamount= parseFloat(debit1) - parseFloat(credit1);
      		    funRoundAmt(netamount,"txtnetamount");
      		  }
      		else{
      			funRoundAmt(0,"txtnetamount");
		    }
            
        });

</script>
<div id="mainAccountStatement"></div>
