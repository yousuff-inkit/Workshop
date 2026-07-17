   <%@page import="com.dashboard.marketing.leasequotationfollowup.leaseQuotationFollowupDAO"%>
     <%leaseQuotationFollowupDAO cmd= new leaseQuotationFollowupDAO(); %>

 
 <%
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String salperson = request.getParameter("salperson")==null?"":request.getParameter("salperson").trim();
	 String chkfollowup = request.getParameter("chkfollowup")==null?"0":request.getParameter("chkfollowup").trim();
	  String followupdate = request.getParameter("followupdate")==null?"0":request.getParameter("followupdate").trim();
  	
 %> 
    <style type="text/css">
  
    
    .rowcolorclass
    {
        background-color: #F5B7B1;
    }
  
</style>       	  
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
 
 
var quotdatan;
 if(temp4!='NA')
{ 
	
	 quotdatan='<%=cmd.quotfollowtsearch(barchval,fromdate,todate,salperson,chkfollowup,followupdate)%>'; 
	
} 
else
{ 
	
	quotdatan;
	
	
	}  

$(document).ready(function () {
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
 						{name : 'totalvalue',type:'number'},
 						 {name : 'fdate', type: 'date' },
 						{name : 'name', type: 'String'  },
 						 {name : 'srno', type: 'String'  },
                     	{name : 'brhid', type: 'String'  },
                     	{name : 'appbtn', type: 'String'  },
                     	{name : 'rowcolor',type:'number'},
                     	{name : 'doc_no' , type: 'int' },
 						{name : 'leasereqdocno', type: 'String'  },
 						
 						{name : 'mobile',type:'string'},
 						{name : 'address',type:'string'},
 						{name : 'email',type:'string'},
 						{name : 'sal_name',type:'string'},
 						{name : 'cldocno',type:'int'},
 						{name : 'date', type: 'date' },
 						{name : 'vocno', type: 'string' },
						
						],
				    localdata: quotdatan,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
        if(data.rowcolor=="1"){
        	return "rowcolorclass";
        }
        else{
        	
        }
          };

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#qutfollowgridnew").jqxGrid(
    {
        width: '99%',
        height: 410,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
       
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlecell',
        pagermode: 'default',
        editable:false,
        columnsresize : true,
        columns: [   
{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
	groupable: false, draggable: false, resizable: false,datafield: '',
	columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',cellclassname:cellclassname,
	cellsrenderer: function (row, column, value) {
			return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
	}
},
{ text: 'Doc_No', datafield: 'doc_no', width: '5%',hidden:true,cellclassname:cellclassname},
{ text: 'Doc No', datafield: 'vocno', width: '5%',cellclassname:cellclassname},
{ text: 'Date', datafield: 'date',  width: '5%',cellsformat:'dd.MM.yyyy' ,cellclassname:cellclassname},
{ text: 'Lease From', datafield: 'leasefromdate',  width: '6%',cellsformat:'dd.MM.yyyy' ,cellclassname:cellclassname, hidden: true},	
{ text: 'Client',datafield: 'name', width: '10%',cellclassname:cellclassname },
{ text: 'Sales Person', datafield: 'sal_name', width: '10%',cellclassname:cellclassname},
{ text: 'Brand', datafield: 'brand', width: '7%',cellclassname:cellclassname},	
{ text: 'Model', datafield: 'model',  width: '8%',cellclassname:cellclassname },
{ text: 'Specification', datafield: 'specification', width: '8%',cellclassname:cellclassname },
{ text: 'Color', datafield: 'color', width: '4%',cellclassname:cellclassname },
{ text: 'Lease in Months', datafield: 'leasemonths', width: '8%' ,cellclassname:cellclassname},
{ text: 'KM use/mnth', datafield: 'kmpermonth', width: '7%',cellclassname:cellclassname },
{ text: 'Group', datafield: 'gname', width: '5%',cellclassname:cellclassname },
{ text: 'Total', datafield: 'totalvalue', width: '5%' ,align:'right',cellsalign:'right',cellclassname:cellclassname},

					 { text: 'Followup Date', datafield: 'fdate', width: '7%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname },
					 { text: ' ', datafield: 'appbtn', width: '7%',columntype: 'button',editable:false, filterable: false,cellclassname:cellclassname},
					 { text: 'hidDoc No',datafield: 'srno', width: '6%',hidden:true },
					 { text: 'Row Color',datafield:'rowcolor',width:'10%',hidden:true,cellclassname:cellclassname},
					
						{ text: 'Lease Req Doc', datafield: 'leasereqdocno', width: '10%',hidden:true },
						{ text: 'Mobile', datafield: 'mobile', width: '20%', hidden: true },
						{ text: 'Address', datafield: 'address', width: '10%', hidden: true },
						{ text: 'Email', datafield: 'email', width: '10%', hidden: true },
						
						{ text: 'Cldocno', datafield: 'cldocno', width: '10%', hidden: true },
					 
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    $('#qutfollowgridnew').on('celldoubleclick', function (event) 
    		{ 
	  var rowindex1=event.args.rowindex;
	  // set null
	  var rows=$('#qutfollowgridnew').jqxGrid('getrows');
		for(var i=0;i<rows.length;i++){
			$('#qutfollowgridnew').jqxGrid('setcellvalue',i,'rowcolor','0');
		}
		$('#qutfollowgridnew').jqxGrid('setcellvalue',rowindex1,'rowcolor','1');
		
	  	$('#date').val(new Date());
	   	   document.getElementById("srno").value="";
			 document.getElementById("brhid").value="";
			 document.getElementById("remarks").value="";
			 document.getElementById("cmbinfo").value="";
			
		 $('#date').jqxDateTimeInput({ disabled: false});
		
		 $('#cmbinfo').attr("disabled",false);
		 $('#remarks').attr("readonly",false);
		 $('#driverUpdate').attr("disabled",false);
	  
    	
	  document.getElementById("brhid").value=$('#qutfollowgridnew').jqxGrid('getcellvalue', rowindex1, "brhid");
	  
	  document.getElementById("srno").value=$('#qutfollowgridnew').jqxGrid('getcellvalue', rowindex1, "srno");
	  
	    $("#leasedetaildiv").load("detailgrid.jsp?srno="+$('#qutfollowgridnew').jqxGrid('getcellvalue', rowindex1, "srno"));
       
    
    		 });	
    
    $('#qutfollowgridnew').on('cellclick', function (event) 
       		{ 
    	   var rowindex1=event.args.rowindex;
      var data=event.args.datafield;
      if(data=="appbtn"){
       
    	  var docno= $('#qutfollowgridnew').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
    	  var leasereqdocno = $("#qutfollowgridnew").jqxGrid('getcellvalue', rowindex1, "leasereqdocno");
    	  var cldocno=$('#qutfollowgridnew').jqxGrid('getcellvalue', rowindex1, "cldocno");
    	  var client=$('#qutfollowgridnew').jqxGrid('getcellvalue', rowindex1, "name");
    	  var address=$('#qutfollowgridnew').jqxGrid('getcellvalue', rowindex1, "address");
    	  var mobile=$('#qutfollowgridnew').jqxGrid('getcellvalue', rowindex1, "mobile");
    	  var email=$('#qutfollowgridnew').jqxGrid('getcellvalue', rowindex1, "email");
    	  var sal_name=$('#qutfollowgridnew').jqxGrid('getcellvalue', rowindex1, "sal_name");
    	  var vocno=$('#qutfollowgridnew').jqxGrid('getcellvalue', rowindex1, "vocno");
    	     var url=document.URL;
     		var reurl=url.split("com/");
     		var mod="A";
     		window.parent.formName.value="Lease Application";
     		window.parent.formCode.value="LQT";
     		var detName= "Lease Application";
     		 var path1='com/operations/marketing/leasequotation/leaseQuotation.jsp';
          	    
        		   /*  var rent=totalval/nmonth;
        		    var res=parseFloat(rent).toFixed(0);
    				  var res1=(res=='NaN'?"0":res); */
        		  var path= path1+"?mod="+mod+"&docno="+docno+"&leasereqdocno="+leasereqdocno+"&cldocno="+cldocno+"&client="+client+
        				  "&address="+address+"&mobile="+mobile+"&email="+email+"&sal_name="+sal_name+"&vocno="+vocno;
    				  
     		top.addTab( detName,reurl[0]+""+path);

    		
    		}
       		});
       
       
   
 
});


</script>
<div id="qutfollowgridnew"></div>