alias Geolix.Adapter.MMDB2
alias Geolix.Adapter.MMDB2TestHelpers.FixtureDownload
alias Geolix.Adapter.MMDB2TestHelpers.FixtureList

{:ok, _} = Application.ensure_all_started(:geolix)
:ok = FixtureDownload.run()

databases =
  [
    %{
      id: :testdata_gz,
      adapter: MMDB2,
      source: Path.join([Geolix.TestData.dir(:mmdb2), "Geolix.mmdb.gz"])
    },
    %{
      id: :testdata_plain,
      adapter: MMDB2,
      source: Path.join([Geolix.TestData.dir(:mmdb2), "Geolix.mmdb"])
    },
    %{
      id: :testdata_tar,
      adapter: MMDB2,
      source: Path.join([Geolix.TestData.dir(:mmdb2), "Geolix.mmdb.tar"])
    },
    %{
      id: :testdata_targz,
      adapter: MMDB2,
      source: Path.join([Geolix.TestData.dir(:mmdb2), "Geolix.mmdb.tar.gz"])
    }
  ] ++
    Enum.map(FixtureList.get(), fn {id, filename} ->
      source = Path.join([__DIR__, "fixtures", filename])

      %{id: id, adapter: MMDB2, source: source}
    end)

Application.put_env(:geolix, :databases, databases)
Enum.each(databases, &Geolix.load_database/1)

ExUnit.start()
