CREATE TABLE CONTROLE_EMPRESA_NOVA
(
 ID_UNN_NOVA                              NUMBER(3),
 ID_EMP_NOVA                              NUMBER(9),
 ID_UNN_REF                               NUMBER(3),
 ID_EMP_REF                               NUMBER(9),
 NM_PROGRAMA                              VARCHAR2(30)
)
TABLESPACE SMALL_DATA;
 
CREATE PUBLIC SYNONYM CONTROLE_EMPRESA_NOVA FOR COMMERCE.CONTROLE_EMPRESA_NOVA;
 
GRANT SELECT, INSERT, UPDATE, DELETE ON CONTROLE_EMPRESA_NOVA TO PUBLIC;