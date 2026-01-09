CREATE TABLE public.clientes (
  idcliente BIGINT DEFAULT nextval('clientes_idcliente_seq'::regclass) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  cpf VARCHAR(11) NOT NULL,
  CONSTRAINT clientes_pkey PRIMARY KEY(idcliente)
) ;

ALTER TABLE public.clientes
  OWNER TO postgres;

CREATE TABLE public.carros (
  idcarro BIGSERIAL,
  modelo VARCHAR(50) NOT NULL,
  data_lancamento DATE NOT NULL,
  CONSTRAINT veiculos_pkey PRIMARY KEY(idcarro)
) ;

ALTER TABLE public.carros
  OWNER TO postgres;

CREATE TABLE public.vendas (
  idvenda BIGINT DEFAULT nextval('vendas_idvenda_seq'::regclass) NOT NULL,
  idcliente INTEGER NOT NULL,
  idcarro INTEGER NOT NULL,
  data_venda DATE NOT NULL,
  CONSTRAINT vendas_pkey PRIMARY KEY(idvenda),
  CONSTRAINT vendas_idcarro_fkey FOREIGN KEY (idcarro)
    REFERENCES public.carros(idcarro)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE,
  CONSTRAINT vendas_idcliente_fkey FOREIGN KEY (idcliente)
    REFERENCES public.clientes(idcliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) ;

ALTER TABLE public.vendas
  OWNER TO postgres;
