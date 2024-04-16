class allAPI {
  //User_GET_Apis--------------------------------
  String financialYearURL = 'LoginApi/FinYearList';
  String getUserDetailsByToken = 'UserDetailsApi/GetUserDetailsByToken';
  String getMedicineCategoriesByStreamId = 'OpeningBalanceApi/GetMedicineCategories';
  String getMedicineCategoriesByStreamCategoryFinYearId = 'OpeningBalanceApi/GetMedicineByCategory';
  String getMedicineListByStreamMissionDirectorateDispendaryAndTypeId = 'OpeningBalanceApi/GetMedicineList';
  String getOpeningBalanceMedicineQuantity = 'OpeningBalanceApi/GetOpeningBalanceMedicineQuantity';
  String getDailyPatientVisitList = 'DailyPatientVisitApi/DailyPatientVisitList';
  String getDispensaryWiseIndentHistory = 'DispensaryApi/GetDispensaryWiseIndentHistory';
  String getDispensaryIndentDetailView = 'DispensaryApi/GetDispensaryIndentDetailView';
  String getCreateIndentViewDetails = 'DispensaryApi/GetCreateIndentViewDetails';
  String getMedicineDetailsByMedicineID = 'DispensaryApi/GetMedicineDetailsByMedicineID';


  //User_POST_Apis--------------------------------

  String dispensaryLoginURL = 'LoginApi/LoginUser';
  String createOrUpdateOpeningBalance = 'OpeningBalanceApi/CreateOrUpdateOpeningBalance';
  String setLatitudeAndLogitude = 'DispensaryApi/SetLatitudeAndLogitude';
  String createDispensaryIndent = 'DispensaryApi/CreateDispensaryIndent';
  String deleteDispensaryIndent = 'DispensaryApi/DeleteDispensaryIndent';
  String postDispensaryIndent = 'DispensaryApi/PostDispensaryIndent';
  String createOrUpdateDailyPatientVisit = 'DailyPatientVisitApi/CreateOrUpdateDailyPatientVisit';

}
