
<%@page import="com.dashboard.invoices.leaseeasy.*"%>
<%ClsLeaseEasyInvoiceDAO leasedao=new ClsLeaseEasyInvoiceDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String type=request.getParameter("type")==null?"":request.getParameter("type");%>

 <style>
 .greenClass
        {
            background-color: #ACF6CB;
        }
   .greyClass
        {
           background-color: #D8D8D8;
        }
 </style>
<script type="text/javascript">

var agmtdata;
var id='<%=id%>';
if(id=="1"){
	agmtdata='<%=leasedao.getAgmtDetailData(branch,date,cldocno,type,id)%>';
}
else
{		
	agmtdata=[];
} 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'rano' , type: 'int' },
                  		{name : 'voc_no' , type: 'int' },
						{name : 'ratype', type: 'String'  },
						/* {name : 'branch', type: 'int'    }, */
						{name : 'fromdate', type: 'date'  },
						{name : 'todate', type: 'date'  },
						{name : 'acno', type: 'String'  },
						{name : 'acname', type: 'string'  },
						{name : 'amount', type: 'number'  },
						{name : 'cldocno',type:'String'},
						{name :'rentalsum',type:'number'},
						{name :'accsum',type:'number'},
						{name :'salikamt',type:'number'},
						{name :'trafficamt',type:'number'},
						{name  :'saliksrvc',type:'number'},
						{name :'datediff',type:'number'},
						{name :'brhid',type:'String'},
						{name :'curid',type:'String'},
						{name :'insurchg',type:'String'},
						{name :'inv_type',type:'String'},
						{name : 'salikcount',type:'String'},
						{name : 'trafficcount',type:'String'},
						{name : 'salamount',type:'String'},
						{name : 'salrate',type:'String'},
						{name : 'account',type:'number'},
						{name : 'trafficsrvc',type:'number'},
						{name : 'account',type:'number'}
						],
				    localdata: agmtdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
	
	$("#agmtDetailGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	
    	});
	
    var cellclassname = function (row, column, value, data) {
        if(typeof(data.amount)=="undefined" || data.amount=="" ){
        	return ""; 
        }
        else{
        	//alert(data.amount);
        	return "greenClass";
        };
          };
 
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#agmtDetailGrid").jqxGrid(
    {
        width: '98%',
        height: 200,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: false,
        selectionmode: 'checkbox',
        pagermode: 'default',
        columnsresize: true,
       sortable:false,
				        columns: [
{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%',cellclassname: cellclassname, cellsrenderer: function (row, column, value) {
    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
}   },	
				{ text: 'LA No', datafield: 'rano', width: '4%' ,cellclassname: cellclassname,hidden:true},
				{ text: 'LA No', datafield: 'voc_no', width: '10%' ,cellclassname: cellclassname},
				/* { text: 'RA Type', datafield: 'ratype', width: '6%'}, */
				{ text: 'Start/Last Invoiced', datafield: 'fromdate', width: '7%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname},
				{ text: 'To', datafield: 'todate', width: '7%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname},
				{ text: 'Ac No', datafield: 'acno', width: '5%'   ,cellclassname: cellclassname,hidden:true},
				{ text: 'Ac No', datafield: 'account', width: '5%'   ,cellclassname: cellclassname},
				{ text: 'Ac Name', datafield: 'acname', width: '23%' ,cellclassname: cellclassname},
				{ text: 'Amount', datafield: 'amount', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				{ text: 'Cldocno', datafield: 'cldocno', width: '12%',cellsformat:'d2',hidden:true,cellclassname: cellclassname},
				{ text: 'Rental Sum', datafield: 'rentalsum', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				{ text: 'Acc Sum', datafield: 'accsum', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				/* { text: 'salik Amt', datafield: 'salikamt', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				{ text: 'Traffic Amt', datafield: 'trafficamt', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				{ text: 'Salik Srvc', datafield: 'saliksrvc', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				{ text: 'Traffic Srvc', datafield: 'trafficsrvc', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname}, */
				{ text: 'DateDifference', datafield: 'datediff', width: '17%',hidden:true,cellclassname: cellclassname},
				{ text: 'Insurance Charges',datafield: 'insurchg', width: '10%',cellsalign:'right',align:'right',cellclassname: cellclassname},
				{ text: 'Brhid', datafield: 'brhid', width: '17%',hidden:true},
				{ text: 'CurId', datafield: 'curid', width: '17%',hidden:true},
				{ text: 'Invtype', datafield: 'inv_type', width: '17%',hidden:true},
				/* { text: 'Salik Count', datafield: 'salikcount', width: '17%',hidden:true},
				{ text: 'Traffic Count', datafield: 'trafficcount', width: '17%',hidden:true},
				{ text: 'Sal Amount', datafield: 'salamount', width: '17%',hidden:true},
				{ text: 'Sal Rate', datafield: 'salrate', width: '17%',hidden:true} */
						/* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
	
$('#agmtDetailGrid').on('rowselect', function (event) 
    		{
    		 
    		});
    
});

</script>
<div id="agmtDetailGrid"></div>