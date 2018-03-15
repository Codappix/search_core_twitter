<?php
namespace Codappix\SearchCoreTwitter\Domain\Index;

/*
 * Copyright (C) 2018  Daniel Siepmann <coding@daniel-siepmann.de>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301, USA.
 */

/**
 * Used to abstract concrete twitter API integration from indexer.
 *
 * Implement this and configure DI to use a different integration.
 */
interface IndexServiceInterface
{
    /**
     * Fetch result from twitter and return as array.
     *
     * The result has to be fetched for the given endpoint, indicating which information to fetch.
     * The twitterAccountIdentifier defines the configured account to use, from typoscript.
     * Parameters should be passed, they should only contain parameters from twitter documentation.
     */
    public function getResult(string $endpoint, string $twitterAccountIdentifier, array $parameters): array;
}
