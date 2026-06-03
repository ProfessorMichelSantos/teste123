from typing import Optional
from fastapi import FastAPI, HTTPException, status, Response
from pydantic import BaseModel, Field

app = FastAPI(title="API de Produtos - Exercícios Práticos")

# Banco em memória
produtos_db = {
    1: {"nome": "Teclado", "preco": 100.0, "estoque": 10, "em_estoque": True, "ativo": True},
    2: {"nome": "Mouse", "preco": 50.0, "estoque": 5, "em_estoque": False, "ativo": True}
}


# Rota raiz (importante para testes)
@app.get("/")
def root():
    return {"msg": "API FastAPI funcionando no Azure"}


# Modelos
class ProdutoSchema(BaseModel):
    nome: str
    preco: float = Field(gt=0, description="O preço deve ser maior que zero")
    estoque: int = Field(ge=0, description="O estoque não pode ser negativo")
    em_estoque: bool = True
    ativo: bool = True


class ProdutoPatchSchema(BaseModel):
    nome: Optional[str] = None
    preco: Optional[float] = Field(None, gt=0)
    estoque: Optional[int] = Field(None, ge=0)
    em_estoque: Optional[bool] = None
