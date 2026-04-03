-- 1. agencybasicinfo (no FK dependencies, create first)
CREATE TABLE agency.agencybasicinfo (
    agencyid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    agencyname VARCHAR NOT NULL,
    businessregno VARCHAR,
    yearestablished VARCHAR,
    agencytype VARCHAR,
    physicaladdress VARCHAR,
    phonenumber VARCHAR,
    businessemail VARCHAR,
    websiteurl VARCHAR,
    inserted_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 2. principalagenttable (depends on agencyemployee)
CREATE TABLE agency.principalagenttable (
    principalagentid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    fullname VARCHAR NOT NULL,
    nationalid VARCHAR,
    employeeid UUID NOT NULL REFERENCES agency.agencyemployee(employeeid),
    earbregistration VARCHAR,
    iskmembership VARCHAR,
    krapin VARCHAR,
    practisingcertno VARCHAR,
    certexpirydate DATE,
    inserted_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 3. compliancetable (depends on agencybasicinfo)
CREATE TABLE agency.compliancetable (
    compliance_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    agencyid UUID NOT NULL REFERENCES agency.agencybasicinfo(agencyid),
    earblicenceno VARCHAR,
    licenceexpirydate DATE,
    incorporationno VARCHAR,
    singlebusinesspermitno VARCHAR,
    indemnityinsuranceprovider VARCHAR,
    policyexpirydate DATE,
    trustaccountbank VARCHAR,
    trustaccountno VARCHAR,
    amlcompliance BOOLEAN DEFAULT FALSE,
    inserted_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 4. areasofops (depends on agencybasicinfo)
CREATE TABLE agency.areasofops (
    operationsid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    agencyid UUID NOT NULL REFERENCES agency.agencybasicinfo(agencyid),
    countytown VARCHAR NOT NULL,         -- one row per county/town
    residential BOOLEAN DEFAULT FALSE,
    commercial BOOLEAN DEFAULT FALSE,
    industrial BOOLEAN DEFAULT FALSE,
    land BOOLEAN DEFAULT FALSE,
    inserted_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 5. servicesoffered (depends on agencybasicinfo)
CREATE TABLE agency.servicesoffered (
    servicesid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    agencyid UUID NOT NULL REFERENCES agency.agencybasicinfo(agencyid),
    propertylettings BOOLEAN DEFAULT FALSE,
    propertymanagement BOOLEAN DEFAULT FALSE,
    shorttermmanagement BOOLEAN DEFAULT FALSE,
    commercialleasing BOOLEAN DEFAULT FALSE,
    inserted_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);