<?php

    $servername = "localhost";
    $username = "id19581590_artmyproject";
    $password = "I_?@N7!Oc8IL/=z?";
    $dbname = "id19581590_myproject";
    $table = "user";

    $action = '';
    $where = '';

    

    if (isset($_POST['action'])) {
        $action = $_POST['action'];
    }

    if (isset($_POST['where'])) {
        $where = $_POST['where'];
    }
    
    

    $conn = new mysqli($servername, $username, $password, $dbname);

    if($conn->connect_error){
        die("Connection Failed:" . $conn->connect_error);
        return;
    }

    if("CREATE_TABLE" == $action){
        $sql = "CREATE TABLE IF NOT EXISTE $table(
            user_id INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            user_name VARCHAR(255) NOT NULL,
            user_surname VARCHAR(255) NOT NULL,
            user_phone VARCHAR(10) NOT NULL,
            user_email VARCHAR(255) NOT NULL,
            user_password VARCHER(255) NOT NULL,
            user_latitude VARCHER(255),
            user_longitude VARCHER(255), 
            user_role VARCHER(255)       )";

        if($conn->query($sql) == TRUE){
            echo "success";
        }
        else{
            echo "error";
        }
        $conn->close();
        return;

    }

    if("GET_ALL" == $action){
        $db_data = array();
        $sql = "SELECT * from $table where user_role = '$where'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("GET_ONLY_USER" == $action){
        $db_data = array();
        $sql = "SELECT * from $table where user_email = '$where'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("GET_ONLY_RIDER" == $action){
        $db_data = array();
        $sql = "SELECT * from rider where rider_email = '$where'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }


    if("GET_ALL_PRODUCT" == $action){
        
        $db_data = array();
        $sql = $_POST["sql"];
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("GET_ONLY_PRODUCT" == $action){
        $db_data = array();
        $sql = "SELECT * FROM product WHERE product_type_id = $where";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("GET_ALL_SOURCE" == $action){
        $db_data = array();
        $sql = "SELECT * from source ";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("GET_IMPORT_PRODUCT" == $action){
        $db_data = array();
        $sql = "SELECT *
        FROM import_order
        INNER JOIN source
        ON import_order.Import_source_id = source.source_id where import_order.Import_status = '$where'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }


    if("GET_IMPORT_PRODUCTDETAI" == $action){
        $db_data = array();
        $sql = "SELECT import_order.Import_order_id,import_order.Import_product_pricetotal,product.product_name,product.product_image,product.product_price,import_order_detail.basket_product_quantity,import_order_detail.basket_product_pricetotal FROM import_order INNER JOIN source ON import_order.Import_source_id = source.source_id INNER JOIN import_order_detail ON import_order.Import_order_id = import_order_detail.Import_order_id INNER JOIN product ON import_order_detail.basket_product_id = product.product_id
        WHERE import_order.Import_order_id = '$where' ";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("GET_USER_PRODUCTDETAI" == $action){
        $db_data = array();
        $sql = "SELECT user_order.order_id,user_order.order_by,user_order.order_responsible_person,user_order.total_price,user_order.order_status,user_order_detail.product_amount,product.product_name,product.product_image,product.product_price FROM user_order 
        INNER JOIN user_order_detail 
        ON user_order.order_id = user_order_detail.order_id
        INNER JOIN product
        ON user_order_detail.product_id = product.product_id
        WHERE user_order.order_id = '$where'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }


    if("GET_ADMIN_BASKET" == $action){
        $db_data = array();
        $sql = "SELECT *
        FROM basket
        INNER JOIN product
        ON basket.basket_product_id = product.product_id;";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("GET_USER_BASKET" == $action){
        $db_data = array();
        $sql = "SELECT user_basket_id,
        user_basket_product_id,
        product.product_name,
        user_basket_quantity,
        user_basket_price,
        user_basket_email,
        basket_product_promotionname,
        basket_product_promotionvalue,
        CAST(user_basket_quantity * user_basket_price AS int) AS simpletotal,
        CAST((user_basket_quantity * user_basket_price) * basket_product_promotionvalue / 100 AS int) AS discount,
        CAST((user_basket_quantity * user_basket_price) - ((user_basket_quantity * user_basket_price) * basket_product_promotionvalue / 100) AS int) AS totalprice,
        product.product_image 
         FROM user_basket 
         INNER JOIN product ON user_basket.user_basket_product_id = product.product_id WHERE user_basket.user_basket_email = '$where'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }


    if("CHECK_USER_BASKET" == $action){
        $db_data = array();
        $sql = "SELECT * FROM user_basket
        INNER JOIN product
        ON user_basket.user_basket_product_id = product.product_id
        WHERE product.product_id = '$where'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }


    if("GET_EXPORT_PRODUCT" == $action){
        $db_data = array();
        $sql = "SELECT user_order.order_id,user_order.order_by,user_order.user_latitude,user_order.user_longitude,user_order.order_responsible_person,user_order.order_responsible_person,
        user_order.order_status,user_order.order_date,user_order.product_amount,user_order.total_price,user.user_name,user.user_surname
        FROM user_order
        INNER JOIN user
        ON user_order.order_by = user.user_email
        where order_status = '$where'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("GET_ONLY_EXPORT_PRODUCT" == $action){
        $db_data = array();
        $order_status = $_POST['order_status'];
        $sql = "SELECT * FROM user_order where order_by = '$where' AND order_status = '$order_status'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("RIDER_GET_EXPORT_PRODUCT" == $action){
        $db_data = array();
        $sql = "SELECT * FROM user_order where order_status = '$where'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("RIDER_GET_ONLYEXPORT_PRODUCT" == $action){
        $where2 = $_POST['where2'];
        $db_data = array();
        $sql = "SELECT * FROM user_order where order_responsible_person = '$where' AND order_status = '$where2'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("RIDER_GET_LOCATION_ORDER" == $action){
        $db_data = array();
        $sql = "SELECT * FROM user_order where order_id = '$where'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("GET_ORDER_DETAIL" == $action){
        $db_data = array();
        $sql = "SELECT user_order.order_id,user_order.order_by,user_order.order_responsible_person,user_order.total_price,user_order.order_status,user_order_detail.product_amount,product.product_name,product.product_image,product.product_price,user_order.order_date FROM user_order
        INNER JOIN user_order_detail 
        ON user_order.order_id = user_order_detail.order_id
        INNER JOIN product 
        ON user_order_detail.product_id = product.product_id where user_order.order_id = '$where'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
    if("GET_ORDER_ONLY_DETAIL" == $action){
        $db_data = array();
        $sql = "SELECT user_order.order_id,user_order.order_by,user_order.order_responsible_person,user_order.total_price,user_order.order_status,user_order_detail.product_amount,product.product_name,product.product_image,product.product_price,user_order.order_date,SUM(user_order_detail.product_amount) FROM user_order
        INNER JOIN user_order_detail 
        ON user_order.order_id = user_order_detail.order_id
        INNER JOIN product 
        ON user_order_detail.product_id = product.product_id 
        where user_order.order_date = '$where'
        GROUP BY product.product_name";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("ADD_BASKET" == $action){
        $basket_product_id = $_POST['basket_product_id'];
        $basket_product_quantity = $_POST['basket_product_quantity'];
        $basket_product_pricetotal = $_POST['basket_product_pricetotal'];
        $source_id = $_POST['source_id'];

        $sql = "INSERT INTO basket (basket_product_id, basket_product_quantity, basket_product_pricetotal,basket_product_source) VALUES ('$basket_product_id','$basket_product_quantity','$basket_product_pricetotal','$source_id')";
        $result = $conn->query($sql);
        echo "success";
        
        $conn->close();
        return;
    }

    if("ADD_USER_BASKET" == $action){
        $basket_product_id = $_POST['basket_product_id'];
        $basket_product_quantity = $_POST['basket_product_quantity'];
        $basket_product_price = $_POST['basket_product_price'];
        $source_id = $_POST['email'];
        $basket_product_promotionname = $_POST['basket_product_promotionname'];
        $basket_product_promotionvalue = $_POST['basket_product_promotionvalue'];

        $sql = "INSERT INTO user_basket (user_basket_product_id, user_basket_quantity, user_basket_price,user_basket_email,basket_product_promotionname,basket_product_promotionvalue) VALUES ('$basket_product_id',$basket_product_quantity,$basket_product_price,'$source_id','$basket_product_promotionname',$basket_product_promotionvalue)";
        $result = $conn->query($sql);
        echo "success";
        
        $conn->close();
        return;
    }

    if("ADD_EMP" == $action){
        $user_name = $_POST['user_name'];
        $user_surname = $_POST['user_surname'];
        $user_phone = $_POST['user_phone'];
        $user_email = $_POST['user_email'];
        $user_password = $_POST['user_password'];
        $user_latitude = '';
        $user_longitude = '';
        $user_role = "customer";
        $sql = "INSERT INTO $table (user_name, user_surname, user_phone, user_email, user_password, user_role) VALUES ('$user_name','$user_surname','$user_phone','$user_email','$user_password','$user_role')";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;

    }

    if("UPDATE_EMP" == $action){
        $user_id = $_POST['user_id'];
        $user_name = $_POST['user_name'];
        $user_surname = $_POST['user_surname'];
        $user_phone = $_POST['user_phone'];
        $user_email = $_POST['user_email'];
        $user_password = $_POST['user_password'];
        $sql = "UPDATE $table SET user_name = '$user_name',user_surname = '$user_surname',user_phone = '$user_phone',user_email = '$user_email', user_password = '$user_password'";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
        
    }

    if("UPDATE_USER" == $action){
        $username = $_POST['username'];
        $usersurname = $_POST['usersurname'];
        $useremail = $_POST['useremail'];
        $userrole = $_POST['userrole'];
        $userphone = $_POST['userphone'];
        $sql = "UPDATE user SET user_name='$username',user_surname='$usersurname',user_phone='$userphone',user_email='$useremail',user_role='$userrole' WHERE user_id = $where";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
        
    }

    if("UPDATE_RIDER" == $action){
        $ridername = $_POST['ridername'];
        $ridersurname = $_POST['ridersurname'];
        $rideremail = $_POST['rideremail'];
        $riderrole = $_POST['riderrole'];
        $riderphone = $_POST['riderphone'];
        $sql = "UPDATE rider SET rider_name ='$ridername',rider_surname='$ridersurname',rider_phone='$riderphone',rider_email='$rideremail',rider_role='$riderrole' WHERE rider_id = $where";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
        
    }

    if("UPDATE_MAP_USER" == $action){
        $latitude = $_POST['latitude'];
        $longitude = $_POST['longitude'];
        $sql = "UPDATE user SET user_latitude ='$latitude',user_longitude='$longitude' WHERE user_email = '$where'";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
        
    }


    if('DELETE_EMP' == $action){
        $user_id = $_POST['user_id'];
        $sql = "DELETE FROM $table WHERE id = $user_id ";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if('DELETE_ORDER' == $action){
        $where = $_POST['where'];
        $sql = "DELETE FROM import_order WHERE import_order.Import_order_id = '$where'";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if('DELETE_ORDERDETAIL' == $action){
        $where = $_POST['where'];
        $sql = "DELETE FROM import_order_detail WHERE import_order_detail.Import_order_id = '$where'";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("ADD_USER_ORDER" == $action){
        $order_id = $_POST['order_id'];
        $order_by = $_POST['order_by'];
        $user_latitude = $_POST['user_latitude'];
        $user_longitude = $_POST['user_longitude'];
        $order_responsible_person = $_POST['order_responsible_person'];
        $total_price = $_POST['total_price'];
        $order_status = $_POST['order_status'];
        $date = $_POST['date'];
        $product_amount = $_POST['product_amount'];

        $sql = "INSERT INTO user_order(order_id,order_by,user_latitude,user_longitude,order_responsible_person,total_price,order_status,order_date,product_amount) VALUES ('$order_id','$order_by','$user_latitude','$user_longitude','$order_responsible_person','$total_price','$order_status','$date','$product_amount')";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;

    }
    if("_LOGIN_ACTION" == $action){   
        $db_data = array();
        $useremail = $_POST['useremail'];
        $password = $_POST['password'];
        $sql = "SELECT * FROM user WHERE user.user_email = '$useremail' AND user.user_password = '$password'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;

    }

    if("RIDER_LOGIN_ACTION" == $action){   
        $db_data = array();
        $useremail = $_POST['useremail'];
        $password = $_POST['password'];
        $sql = "SELECT * FROM rider WHERE rider.rider_email = '$useremail' AND rider.rider_password = '$password'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;

    }


    

    if("ADD_ORDERDETAIL" == $action){
        $order_id = $_POST['order_id'];
        $product_id = $_POST['product_id'];
        $product_amount = $_POST['product_amount'];
        $product_per_pice = $_POST['product_per_pice'];
        $product_promotion_name = $_POST['product_promotion_name'];
        $product_promotion_value = $_POST['product_promotion_value'];

        $sql = "INSERT INTO user_order_detail(order_id,product_id,product_amount,product_per_price,product_promotion_name,product_promotion_value) VALUES ('$order_id','$product_id','$product_amount','$product_per_pice','$product_promotion_name','$product_promotion_value')";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    if("_ADD_IMPORTPRODUCT_DETAIL" == $action){
        $Import_order_id = $_POST['Import_order_id'];
        $basket_product_id = $_POST['basket_product_id'];
        $basket_product_quantity = $_POST['basket_product_quantity'];
        $basket_product_pricetotal = $_POST['basket_product_pricetotal'];
        $DateTime = $_POST['DateTime'];

        $sql = "INSERT INTO import_order_detail(Import_order_id,basket_product_id,basket_product_quantity,basket_product_pricetotal,DateTime) VALUES ('$Import_order_id','$basket_product_id','$basket_product_quantity','$basket_product_pricetotal','$DateTime')";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    if("_ADD_IMPORTPRODUCT" == $action){
        $Import_order_id = $_POST['Import_order_id'];
        $Import_product_pricetotal = $_POST['Import_totalprice'];
        $Import_date = $_POST['DateTime'];
        $Import_status = 'สินค้ายังไม่ครบ';
        $source_id = $_POST['source_id'];

        $sql = "INSERT INTO import_order(Import_order_id,Import_product_pricetotal,Import_date,Import_status,Import_source_id) VALUES ('$Import_order_id','$Import_product_pricetotal','$Import_date','$Import_status','$source_id')";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;

    }

    if("_ADD_PROMPTION" == $action){
        $promotion_name = $_POST['promotion_name'];
        $promotion_value = $_POST['promotion_value'];

        $sql = "INSERT INTO promotion(promotion_name, promotion_value) VALUES ('$promotion_name','$promotion_value')";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;

    }

    if("_ADD_PROMPTION" == $action){
        $promotion_name = $_POST['promotion_name'];
        $promotion_value = $_POST['promotion_value'];

        $sql = "INSERT INTO promotion(promotion_name, promotion_value) VALUES ('$promotion_name','$promotion_value')";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;

    }

    if("ADD_PRODUCT_PROMOTION" == $action){
        $product_id = $_POST['product_id'];
        $promotion_id = $_POST['promotion_id'];
        $start_date = $_POST['start_date'];
        $end_date = $_POST['end_date'];

        $sql = "INSERT INTO product_promotion(product_id, promotion_id, start_date, end_date) VALUES ('$product_id','$promotion_id','$start_date','$end_date')";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;

    }

    if("_ADD_PRODUCTTYPE" == $action){
        $product_type_name = $_POST['producttype_name'];

        $sql = "INSERT INTO product_type(product_type_name) VALUES ('$product_type_name')";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;

    }

    if("DELETE_BASKET" == $action){ 
        $sql = "DELETE FROM basket";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    if("DELETE_USER_BASKET" == $action){ 
        $sql = "DELETE FROM user_basket WHERE user_basket.user_basket_email = '$where'";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    if("DELETE_ONLY_BASKET" == $action){ 
        $sql = "DELETE FROM user_basket WHERE user_basket.user_basket_id = '$where'";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    if("DELETEPRODUCTPROMOTION" == $action){ 
        $product_id = $_POST['product_id'];
        $promotion_id = $_POST['promotion_id'];
        $sql = "DELETE FROM product_promotion WHERE product_promotion.product_id = $product_id AND product_promotion.promotion_id = $promotion_id";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    if("ORDER_SUBMIT" == $action){ 
        $sql = "UPDATE import_order SET Import_status= 'ส่งแล้ว' WHERE Import_order_id = '$where'";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    if("RIDER_UPDATE_ORDER" == $action){ 
        $where2 = $_POST['where2'];
        $where3 = $_POST['where3'];
        $sql = "UPDATE user_order SET order_responsible_person = '$where',order_status= '$where2' WHERE order_id = '$where3'";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    if("PRODUCT_QUANTITY_UPDATE" == $action){ 
        $where2 = $_POST['where2'];
        $sql = "UPDATE product SET product_quantity = product_quantity  - '$where2', export_product = export_product + '$where2'  WHERE product_id = '$where'";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }
    
    if("IMPORT_PRODUCT_QUANTITY_UPDATE" == $action){ 
        $where2 = $_POST['where2'];
        $sql = "UPDATE product SET import_product = import_product  + '$where2', export_product = export_product + '$where2'  WHERE product_id = '$where'";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }
    if("CANCLE_ORDER" == $action){ 
        $sql = "UPDATE user_order SET order_status = 'รายการที่ยกเลิก' WHERE order_id = '$where'";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    if("ACCEPT_ORDER" == $action){ 
        $sql = "UPDATE user_order SET order_status = 'รอการยืนยันการเเพ็คของ' WHERE order_id = '$where'";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    if("ACCEPTPACKGE_ORDER" == $action){ 
        $sql = "UPDATE user_order SET order_status = 'ยังไม่มีใครรับ' WHERE order_id = '$where'";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    if("WAITCANCEL_ORDER" == $action){ 
        $sql = "UPDATE user_order SET order_status = 'รอการตอบกลับการยกเลิก' WHERE order_id = '$where'";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    if("ADD_PRODUCT" == $action){ 
        $sql = $_POST["sql"];
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    if("GET_ALL_IMPORT_PRODUCTDETAI" == $action){
        $db_data = array();
        $sql = "SELECT import_order.Import_order_id,import_order.Import_product_pricetotal,product.product_name,product.product_image,product.product_price,import_order_detail.basket_product_quantity,import_order_detail.basket_product_pricetotal,
        SUM(import_order_detail.basket_product_quantity)
        FROM import_order
        INNER JOIN source ON import_order.Import_source_id = source.source_id 
        INNER JOIN import_order_detail ON import_order.Import_order_id = import_order_detail.Import_order_id 
        INNER JOIN product 
        ON import_order_detail.basket_product_id = product.product_id
        GROUP BY product.product_name";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    
    if("CHANGE_USERPASSWORD" == $action){ 
        $where2 = $_POST['where2'];
        $sql = "UPDATE user SET user_password = '$where2' WHERE user_email = '$where'";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    

    if("CHANGE_RIDERPASSWORD" == $action){ 
        $where2 = $_POST['where2'];
        $sql = "UPDATE rider SET rider_password = '$where2' WHERE rider_email = '$where'";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    if("GETONLY_PROMOTION" == $action){ 
        $where2 = $_POST['where2'];
        $sql = "SELECT * FROM promotion WHERE promotion_name = '$where' OR promotion_value = $where2";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("GETONLY_PROMOTION_BYNAME" == $action){ 
        $sql = "SELECT * FROM promotion WHERE promotion_name = '$where'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    

    if("GETALL_PRODUCTTYPE" == $action){ 
        $sql = "SELECT * FROM product_type WHERE product_type_name = '$where'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("GET_ALL_PRODUCT_PROMOTION" == $action){ 
        $sql = "SELECT promotion.promotion_id,promotion.promotion_name,promotion.promotion_value,product.product_id,product.product_name,product_promotion.start_date,product_promotion.end_date FROM product_promotion
        INNER JOIN promotion
        ON product_promotion.promotion_id = promotion.promotion_id
        INNER JOIN product
        ON product.product_id = product_promotion.product_id";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
    if("GET_ONLY_PRODUCT_PROMOTION" == $action){ 
        $where2 = $_POST['where2'];
        $sql = "SELECT promotion.promotion_id,promotion.promotion_name,promotion.promotion_value,product.product_id,product.product_name,product_promotion.start_date,product_promotion.end_date FROM product_promotion
        INNER JOIN promotion
        ON product_promotion.promotion_id = promotion.promotion_id
        INNER JOIN product
        ON product.product_id = product_promotion.product_id
        WHERE product_promotion.product_id = '$where' AND product_promotion.promotion_id = '$where2'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("GET_ONLYVALUE_PRODUCT_PROMOTION" == $action){ 
        $where2 = $_POST['where2'];
        $sql = "SELECT product_promotion.promotion_id,promotion.promotion_name,promotion.promotion_value,product.product_id,product.product_name,start_date,end_date FROM product_promotion 
        INNER JOIN product ON product_promotion.product_id = product.product_id 
        INNER JOIN promotion ON product_promotion.promotion_id = promotion.promotion_id 
        WHERE product.product_id = '$where' AND '$where2' BETWEEN product_promotion.start_date AND product_promotion.end_date";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }


    if("GETALL_PROMOTION" == $action){ 
        $sql = "SELECT * FROM promotion";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }


    if("DELETEPROMOTION" == $action){ 
        $sql = "DELETE FROM promotion WHERE promotion_id = $where ";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    if("EDITPROMOTION" == $action){ 
        $where2 = $_POST['where2'];
        $where3 = $_POST['where3'];
        $sql = "UPDATE promotion SET promotion_name = '$where2',promotion_value = '$where3' WHERE promotion_id = $where";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    
    if("GETALL_PRODUCTTYPE_1" == $action){ 
        $sql = "SELECT * FROM product_type";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("GETONLY_PRODUCTTYPE_1" == $action){ 
        $sql = "SELECT * FROM `product_type` WHERE product_type_name = '$where'";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }

    if("DELETEPRODUCTTYPE" == $action){ 
        $sql = "DELETE FROM product_type WHERE product_type_id = $where";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }

    if("EDITPRODUCTTYPE" == $action){ 
        $where2 = $_POST['where2'];
        $sql = "UPDATE product_type SET product_type_name= '$where2' WHERE product_type_id = '$where'";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }


    


?>