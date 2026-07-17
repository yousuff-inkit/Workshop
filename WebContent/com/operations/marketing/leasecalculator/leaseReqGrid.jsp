<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.leasecalculator.*" %>
<% String contextPath=request.getContextPath();%>
<%ClsLeaseCalculatorDAO calcdao1=new ClsLeaseCalculatorDAO(); %>
<%String reqdocno=request.getParameter("reqdocno")==null?"0":request.getParameter("reqdocno");%>
<%String id=request.getParameter("id")==null?"0":request.getParameter("id");%>
<%String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");%>
<style>
.focusClass{
	background-color:#5ae1b5;
}
</style>
<script type="text/javascript">
		var reqdocno='<%=reqdocno%>';
		var reqdata;

		if(reqdocno!="0" && reqdocno!=""){
			reqdata='<%=calcdao1.getReqData(reqdocno,id,docno)%>';
		}
		else{
			
		}
        
		$(document).ready(function() { 
                   
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'leasefromdate', type: 'date' }, 
     						{name : 'brand', type: 'string'   },
     						{name : 'model', type: 'string'  },
     						{name : 'specification', type: 'string'   },
     						{name : 'color', type: 'string'   },
     						{name : 'leasemonths', type: 'number' },
     						{name : 'kmpermonth',type:'number'},
     						{name : 'gname',type:'string'},

						{name : 'quotbtn', type: 'String'  },

     						{name : 'brdid',type:'number'},
     						{name : 'modelid',type:'number'},
     						{name : 'clrid',type:'number'},
     						{name : 'grpid',type:'number'},
     						{name : 'rowcolor',type:'number'},
     						{name : 'srno',type:'number'},
     						{name :'dealer',type:'string'},
     						{name : 'hiddealer',type:'string'},
     						{name :'purchcost',type:'number'},
     						{name : 'downpytper',type:'number'},
     						{name : 'interestper',type:'number'},
     						{name : 'creditcardper',type:'number'},
     						{name : 'authority',type:'string'},
     						{name : 'hidauthority',type:'string'},
     						{name : 'authid',type:'string'},
     						{name : 'profitper',type:'number'},
     						{name : 'overheadper',type:'number'},
     						{name : 'others',type:'number'},
     						{name : 'discount',type:'number'},
     						{name :'savestatus',type:'int'},
     						{name : 'totalvalue',type:'number'},
     						{name : 'confirmstatus',type:'int'}
     						
     						
                        ],
                         localdata: reqdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var cellclassname = function (row, column, value, data) {
                if(data.rowcolor=="1"){
                	return "focusClass";
                }
                else{
                	
                }
                  };
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#leaseReqGrid").jqxGrid(
            {
                width: '98%',
                height: 130,
                source: dataAdapter,
                editable: false,
                showaggregates: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                	/* var rows = $('#jqxleasecalculator').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxleasecalculator').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'fifthyear' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {  
                            var commit = $("#jqxleasecalculator").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    } */ 
                },
                       
                columns: [
							{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
    							groupable: false, draggable: false, resizable: false,datafield: '',
    							columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',cellclassname:cellclassname,
    							cellsrenderer: function (row, column, value) {
     								return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
    							}
							},
							{ text: 'Lease From', datafield: 'leasefromdate',  width: '10%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname },	
							{ text: 'Brand', datafield: 'brand', width: '10%',cellclassname:cellclassname},	
							{ text: 'Model', datafield: 'model',  width: '16%' ,cellclassname:cellclassname},
							{ text: 'Specification', datafield: 'specification', width: '18%' ,cellclassname:cellclassname},
							{ text: 'Color', datafield: 'color', width: '8%' ,cellclassname:cellclassname},
							{ text: 'Lease in Months', datafield: 'leasemonths', width: '8%' ,cellclassname:cellclassname},
							{ text: 'KM use per month', datafield: 'kmpermonth', width: '8%' ,cellclassname:cellclassname},
							{ text: 'Group', datafield: 'gname', width: '8%' ,cellclassname:cellclassname},
							{ text: 'Total', datafield: 'totalvalue', width: '10%' ,align:'right',cellsalign:'right',cellclassname:cellclassname},

							{ text: ' ', datafield: 'quotbtn', width: '6%',columntype: 'button',editable:false, filterable: false},

							{ text: 'Brand Id',datafield:'brdid',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'model Id',datafield:'modelid',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Color Id',datafield:'clrid',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Group Id',datafield:'grpid',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Row Color',datafield:'rowcolor',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Srno',datafield:'srno',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Dealer',datafield:'dealer',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Dealer Docno',datafield:'hiddealer',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Purchase Cost',datafield:'purchcost',width:'10%',hidden:true,cellclassname:cellclassname,cellsformat:'d2'},
							{ text: 'Down Payment %',datafield:'downpytper',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Interest %',datafield:'interestper',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Credit Card %',datafield:'creditcardper',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Authority Name',datafield:'authority',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Authority Doc No',datafield:'hidauthority',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Authority Code',datafield:'authid',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Profit %',datafield:'profitper',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Over Head %',datafield:'overheadper',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Others',datafield:'others',width:'10%',hidden:true,cellclassname:cellclassname,cellsformat:'d2'},
							{ text: 'Discount',datafield:'discount',width:'10%',hidden:true,cellclassname:cellclassname,cellsformat:'d2'},
							{ text: 'Save Status',datafield:'savestatus',width:'10%',hidden:true,cellclassname:cellclassname},
							{ text: 'Confirm Status',datafield:'confirmstatus',width:'10%',hidden:true,cellclassname:cellclassname},
						]
            });




		 $('#leaseReqGrid').on('cellclick', function (event) 
            		{ 
             
           var data=event.args.datafield;
		   if(data=="quotbtn"){
            	// alert("===="+event.args.rowindex);
    			var value = $('#leaseReqGrid').jqxGrid('getcelltext', event.args.rowindex, "quotbtn");
    			// alert("=== "+value);
    			
    			if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
      		  	  
     		  	   var url=document.URL;
			 //alert(url);
			var reurl=url.split("com/");
			 // alert(reurl[0]);       
			         $("#docno").prop("disabled", false);
			var win= window.open(reurl[0]+"com/operations/marketing/leasecalculator/printcalQuot1?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		      
			 win.focus();
    			}
    			}
            		});




            
            $('#leaseReqGrid').on('celldoubleclick', function (event) 
            		{ 
            			document.getElementById("lblvehicle").innerText="";
            			if(document.getElementById("mode").value=="A"){
            				return false;
            			}
						var data=event.args.datafield;
						if(data!="quotbtn"){
		            	var rowindex1=event.args.rowindex;
						var rows=$('#leaseReqGrid').jqxGrid('getrows');
						for(var i=0;i<rows.length;i++){
							$('#leaseReqGrid').jqxGrid('setcellvalue',i,'rowcolor','0');
						}
						$('#leaseReqGrid').jqxGrid('setcellvalue',rowindex1,'rowcolor','1');
						document.getElementById("lblvehicle").innerText=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'brand')+" "+$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'model')+" Group "+$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'gname');
						document.getElementById("savestatus").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'savestatus');
						document.getElementById("confirmstatus").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'confirmstatus');
						document.getElementById("leasemonths").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'leasemonths');
						document.getElementById("kmpermonth").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'kmpermonth');
						document.getElementById("grpid").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'grpid');
						document.getElementById("srno").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'srno');
						if($('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'savestatus')=="1"){
							
							document.getElementById("dealer").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'dealer');
							document.getElementById("hiddealer").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'hiddealer');
							document.getElementById("purchcost").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'purchcost');
							document.getElementById("downpytper").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'downpytper');
							document.getElementById("interestper").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'interestper');
							document.getElementById("creditper").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'creditcardper');
							document.getElementById("authority").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'authority');
							document.getElementById("hidauthority").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'hidauthority');
							document.getElementById("authid").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'authid');
							document.getElementById("profitper").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'profitper');
							document.getElementById("overheadper").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'overheadper');
							document.getElementById("others").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'others');
							document.getElementById("discount").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'discount');
							var srno=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'srno');
							var leasereqdocno=document.getElementById("leasereqdoc").value;
							var docno=document.getElementById("docno").value;
							$('#leasecalculatordiv').load('leaseCalculatorGrid.jsp?srno='+srno+'&leasereqdocno='+leasereqdocno+'&docno='+docno+'&id=2');
							document.getElementById("btnleaseedit").disabled=false;
						}
						else{
							$('#leasecalculatordiv').load('leaseCalculatorGrid.jsp?srno=0&leasereqdocno=0&docno=0&id=2');
							document.getElementById("dealer").value="";
							$('#dealer').attr("placeholder", "Press F3 to Search");
							document.getElementById("hiddealer").value="";
							document.getElementById("purchcost").value="";
							document.getElementById("downpytper").value="";
							document.getElementById("interestper").value="";
							document.getElementById("creditper").value="";
							document.getElementById("authority").value="";
							$('#authority').attr("placeholder", "Press F3 to Search");
							document.getElementById("hidauthority").value="";
							document.getElementById("authid").value="";
							document.getElementById("profitper").value="";
							document.getElementById("overheadper").value="";
							document.getElementById("others").value="";
							document.getElementById("discount").value="";
							document.getElementById("btnleaseedit").style.display="block";
							document.getElementById("btnleaseedit").disabled=false;
						}
						if($('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'savestatus')=="1" && $('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'confirmstatus')=="0"){
							document.getElementById("btnconfirm").style.display="block";
						}
						else{
							document.getElementById("btnconfirm").style.display="none";
						}
						if($('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'confirmstatus')=="1"){
							document.getElementById("btnleaseedit").disabled=true;
						}
						}
            		}); 
        
            
            //Add empty row
         	 /* $("#jqxleasecalculator").jqxGrid('addrow', null, {}); */
         	            
        });
    </script>
    <div id="leaseReqGrid"></div>
    
