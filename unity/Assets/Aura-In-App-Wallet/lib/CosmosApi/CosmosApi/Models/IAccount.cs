namespace CosmosApi.Models
{
    public interface IAccount
    {
        PublicKey GetPublicKey();
        ulong GetSequence();
        ulong GetAccountNumber();
    }
}