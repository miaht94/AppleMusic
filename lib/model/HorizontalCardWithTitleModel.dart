import 'package:flutter/cupertino.dart';

class HorizontalCardWithTitleModel {
    HorizontalCardWithTitleModel(this._category, this._title, this._primaryDes ,this._primaryImagePath,  this._secondaryDes, this._secondaryImagePath);
    String _title;
    String _primaryImagePath;
    String _secondaryImagePath;
    String _primaryDes;
    String _secondaryDes;
    String _category;

    String get title {
        return _title;
    }

    String get primaryImagePath {
        return _primaryImagePath;
    }

    String get secondaryImagePath {
        return _secondaryImagePath;
    }

    String get primaryDes {
        return _primaryDes;
    }

    String get secondaryDes {
        return _secondaryDes;
    }
    
    String get category {
      return _category;
    }

    static List<HorizontalCardWithTitleModel> getSampleData() {
      return [
        new HorizontalCardWithTitleModel("Album mới", "Apricot Princess", "Rex Orange County", "https://www.rutarock.com/wp-content/uploads/2019/02/Rex-Orange-County.jpg" , "Nhịp điệu vui tươi bày tỏ tâm trạng hứng khởi của nam ca sĩ.", "https://cdn-amz.fadoglobal.io/images/I/71PuqTZtIEL.jpg") ,
        new HorizontalCardWithTitleModel("Album mới", "Apricot Princess", "Rex Orange County", "https://www.rutarock.com/wp-content/uploads/2019/02/Rex-Orange-County.jpg" , "Nhịp điệu vui tươi bày tỏ tâm trạng hứng khởi của nam ca sĩ.", "https://cdn-amz.fadoglobal.io/images/I/71PuqTZtIEL.jpg") ,
        new HorizontalCardWithTitleModel("Album mới", "Apricot Princess", "Rex Orange County", "https://www.rutarock.com/wp-content/uploads/2019/02/Rex-Orange-County.jpg" , "Nhịp điệu vui tươi bày tỏ tâm trạng hứng khởi của nam ca sĩ.", "https://cdn-amz.fadoglobal.io/images/I/71PuqTZtIEL.jpg")                   
      ];
    }
}