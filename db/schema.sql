CREATE TABLE postcodify_addresses (
    id INTEGER PRIMARY KEY,
    address_id CHAR(25),
    postcode5 CHAR(5),
    postcode6 CHAR(6),
    road_id NUMERIC(14),
    num_major INTEGER(5),
    num_minor INTEGER(5),
    is_basement INTEGER(1) DEFAULT 0,
    dongri_ko VARCHAR(80),
    dongri_en VARCHAR(80),
    jibeon_major INTEGER(5),
    jibeon_minor INTEGER(5),
    is_mountain INTEGER(1) DEFAULT 0,
    building_name VARCHAR(80),
    other_addresses VARCHAR(2000),
    updated NUMERIC(8)
);
CREATE INDEX postcodify_addresses_address_id ON postcodify_addresses (address_id);
CREATE INDEX postcodify_addresses_road_id ON postcodify_addresses (road_id);
CREATE INDEX postcodify_addresses_postcode6 ON postcodify_addresses (postcode6);
CREATE INDEX postcodify_addresses_postcode5 ON postcodify_addresses (postcode5);

--
--
--
CREATE TABLE postcodify_keywords (
    seq INTEGER PRIMARY KEY,
    address_id INTEGER NOT NULL,
    keyword_crc32 INTEGER(10)
);
CREATE INDEX postcodify_keywords_address_id ON postcodify_keywords (address_id);
CREATE INDEX postcodify_keywords_keyword_crc32 ON postcodify_keywords (keyword_crc32);

--
--
--
CREATE TABLE postcodify_roads (
    road_id NUMERIC(14) PRIMARY KEY,
    road_name_ko VARCHAR(40),
    road_name_en VARCHAR(40),
    sido_ko VARCHAR(40),
    sido_en VARCHAR(40),
    sigungu_ko VARCHAR(40),
    sigungu_en VARCHAR(40),
    ilbangu_ko VARCHAR(40),
    ilbangu_en VARCHAR(40),
    eupmyeon_ko VARCHAR(40),
    eupmyeon_en VARCHAR(40)
);
CREATE INDEX postcodify_roads_sido_ko ON postcodify_roads (sido_ko);
CREATE INDEX postcodify_roads_sigungu_ko ON postcodify_roads (sigungu_ko);
CREATE INDEX postcodify_roads_ilbangu_ko ON postcodify_roads (ilbangu_ko);
CREATE INDEX postcodify_roads_eupmyeon_ko ON postcodify_roads (eupmyeon_ko);

--
--
--
CREATE TABLE postcodify_buildings (
    seq INTEGER PRIMARY KEY,
    address_id INTEGER NOT NULL,
    keyword VARCHAR(120)
);
CREATE INDEX postcodify_buildings_address_id ON postcodify_buildings (address_id);

--
--
--
CREATE TABLE postcodify_numbers (
    seq INTEGER PRIMARY KEY,
    address_id INTEGER NOT NULL,
    num_major INTEGER(5),
    num_minor INTEGER(5)
);
CREATE INDEX postcodify_numbers_address_id ON postcodify_numbers (address_id);
CREATE INDEX postcodify_numbers_num_major ON postcodify_numbers (num_major);
CREATE INDEX postcodify_numbers_num_minor ON postcodify_numbers (num_minor);

--
--
--
CREATE TABLE postcodify_settings (
    k VARCHAR(20) PRIMARY KEY,
    v VARCHAR(40)
);

--
--
--
CREATE TABLE postcodify_english (
    seq INTEGER PRIMARY KEY,
    ko VARCHAR(40),
    ko_crc32 INTEGER(10),
    en VARCHAR(40),
    en_crc32 INTEGER(10)
);
CREATE INDEX postcodify_english_ko ON postcodify_english (ko);
CREATE INDEX postcodify_english_ko_crc32 ON postcodify_english (ko_crc32);
CREATE INDEX postcodify_english_en ON postcodify_english (en);
CREATE INDEX postcodify_english_en_crc32 ON postcodify_english (en_crc32);

--
--
--
CREATE TABLE postcodify_pobox (
    seq INTEGER PRIMARY KEY,
    address_id INTEGER NOT NULL,
    keyword VARCHAR(40),
    range_start_major INTEGER(5),
    range_start_minor INTEGER(5),
    range_end_major INTEGER(5),
    range_end_minor INTEGER(5)
);
CREATE INDEX postcodify_pobox_address_id ON postcodify_pobox (address_id);
CREATE INDEX postcodify_pobox_range_start_major ON postcodify_pobox (range_start_major);
CREATE INDEX postcodify_pobox_range_start_minor ON postcodify_pobox (range_start_minor);
CREATE INDEX postcodify_pobox_range_end_major ON postcodify_pobox (range_end_major);
CREATE INDEX postcodify_pobox_range_end_minor ON postcodify_pobox (range_end_minor);
