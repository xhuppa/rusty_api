// @generated automatically by Diesel CLI.

diesel::table! {
    categories (category_id) {
        category_id -> Integer,
        #[max_length = 255]
        category_name -> Nullable<Varchar>,
    }
}

diesel::table! {
    service_provider_type (service_provider_type_id) {
        service_provider_type_id -> Integer,
        #[max_length = 255]
        service_provider_name -> Varchar,
    }
}

diesel::table! {
    user (user_id) {
        user_id -> Integer,
        #[max_length = 255]
        username -> Varchar,
        #[max_length = 255]
        email -> Varchar,
        #[max_length = 255]
        password -> Varchar,
        #[max_length = 255]
        first_name -> Nullable<Varchar>,
        #[max_length = 255]
        last_name -> Nullable<Varchar>,
        date_of_birth -> Nullable<Date>,
        user_type -> Nullable<Integer>,
        created_at -> Nullable<Timestamp>,
        updated_at -> Nullable<Timestamp>,
    }
}

diesel::table! {
    user_type (user_type_id) {
        user_type_id -> Integer,
        #[max_length = 255]
        name -> Varchar,
    }
}

diesel::table! {
    vendor (vendor_id) {
        vendor_id -> Integer,
        #[max_length = 255]
        vendor_name -> Nullable<Varchar>,
        vendor_pricing -> Nullable<Decimal>,
        vendor_description -> Nullable<Text>,
        category_id -> Nullable<Integer>,
    }
}

diesel::table! {
    venue (venue_id) {
        venue_id -> Integer,
        #[max_length = 255]
        name -> Nullable<Varchar>,
        location_id -> Nullable<Integer>,
    }
}

diesel::joinable!(user -> user_type (user_type));
diesel::joinable!(vendor -> categories (category_id));

diesel::allow_tables_to_appear_in_same_query!(
    categories,
    service_provider_type,
    user,
    user_type,
    vendor,
    venue,
);
