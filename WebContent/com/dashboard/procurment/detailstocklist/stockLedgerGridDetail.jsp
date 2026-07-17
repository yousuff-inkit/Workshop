<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.procurment.detailstocklist.ClsDetailStockListDAO"%>
 <% ClsDetailStockListDAO searchDAO = new ClsDetailStockListDAO();  
 
	String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 	String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();

  	String psrno = request.getParameter("psrno")==null?"0":request.getParameter("psrno").trim();
	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
	String hidbrand="0", hidtype="0", hidsubcat="0", hidproduct="0", branchid="0", hidept="0",hidcat="0";
	
	String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
	
 %> 
     
<style type="text/css">

 .op
  {
      background-color:#FCEFCE;
  }
  
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .greyClass
    {
        background-color: #e6e6e6;
    }
    
     .orangeClass
    {
        background-color: #FFEBC2;
    }
  .sl
  {
      background-color:#FCEFCE;
  }
  
 .prd
  {
      background-color:#ffe0cc;
  }
  
 .pr
  {
      background-color:#EBEBC1;
  }
  
    
   .advanceClass5
  {
      background-color: #FCC4F7;
  }
   .advanceClass4
  {
       background-color: #efd4f7;
  }
   .advanceClass3
  {
     
      background-color: #C4F3F5        ;
  }
   .advanceClass2
  {
      background-color:/*  #bed9f4; */ #CFECF1    ;  
  }
   .advanceClass1
  {
      background-color:   #eff4be;  ;
  }
    .balanceClass
  {
      background-color: #E0F8F1;
  }
    
</style>
<script type="text/javascript"> 
    
       var detdata;
       var type='<%=type%>';
 
	  	if(type=='2'){   
	 
	  	  detdata='<%=searchDAO.stockLedgerDetail(session,fromDate,toDate,psrno,load)%>';    
	  	} 
		else{
			detdata;
	}

$(document).ready(function () {
	  var rendererstring1=function (aggregates){
       	var value=aggregates['sum1'];
       	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
       }    
    
 var rendererstring=function (aggregates){
 	var value=aggregates['sum'];
	if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
	   {
		value=0.0;
	   }
 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
 }
    
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                     
                  
              
                        {name : 'date', type: 'date'  },
                        {name : 'docno', type: 'number'  },
                        {name : 'dtype', type: 'String'  },
                        {name : 'accountname', type: 'String'  },
                    	{name : 'qty', type: 'number'  },
						{name : 'balqty', type: 'number'  },
						{name : 'pstatus', type: 'int'  },
						
						
			 
					 
						
						
						],
				    localdata: detdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
    	
		 if (data.pstatus=='1') {
            return "advanceClass4";
        }
		   
		 else
			 {
			 return "balanceClass";
			 }
		 
		   
		 ;
    };

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#jqxStockDetailGrid").jqxGrid(
    {
        width: '98%',
        height: 530,
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
       // showaggregates:true,
       // showstatusbar:true,
        columnsresize:true,
       // statusbarheight: 21,
        pagermode: 'default',
        editable:false,
        columns: [   
                   { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false, pinned: true,
                      datafield: 'sl', columntype: 'number', width: '5%', cellclassname: cellclassname,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    } ,
                     
                     
           	         { text: 'DATE', datafield: 'date',  width: '8%' , cellclassname: cellclassname,cellsformat:'dd.MM.yyyy' }, 
           	      
					 { text: 'DOC NO', datafield: 'docno',  width: '8%' , cellclassname: cellclassname},
					 { text: 'TYPE', datafield: 'dtype',  width: '8%' , cellclassname: cellclassname},
					 { text: 'Account Name', datafield: 'accountname' , cellclassname: cellclassname },
					 { text: 'Qty',datafield: 'qty', width: '10%' , cellsformat: 'd2' , cellclassname: cellclassname },
					 { text: 'Bal Qty',datafield: 'balqty', width: '10%',   cellsformat: 'd2' , cellclassname: cellclassname },
					 { text: 'pstatus',datafield: 'pstatus', width: '10%'  , cellclassname: cellclassname,hidden:true},
					 
				    		
					], 
   
    });

    $("#overlay2, #PleaseWait2").hide();
});


</script>
<div id="jqxStockDetailGrid"></div>